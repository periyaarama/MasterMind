import 'package:flutter/material.dart';
import 'package:master_mind/screens/crud_owner/models/book.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class CreditCardPaymentBook extends StatefulWidget {
  final Book book;
  const CreditCardPaymentBook({super.key, required this.book});

  @override
  State<CreditCardPaymentBook> createState() => _CreditCardPaymentBookState();
}

class _CreditCardPaymentBookState extends State<CreditCardPaymentBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  bool _isLoading = false;
  List<Map<String, String>> creditCards = [];

  @override
  void initState() {
    super.initState();
    _fetchCreditCards();
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, Map<String, String> card) async {
    final user = FirebaseAuth.instance.currentUser;
    final bookId = widget.book.documentId;

    if (user != null) {
      final purchaseCollection =
          FirebaseFirestore.instance.collection('purchase');
      final bookDoc =
          FirebaseFirestore.instance.collection('books').doc(bookId);
      final docSnapshot = await purchaseCollection
          .where('userId', isEqualTo: user.uid)
          .where('bookId', isEqualTo: bookId)
          .get();

      if (docSnapshot.docs.isEmpty) {
        // Show confirmation dialog before adding to purchase
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Confirm Purchase',
                style: TextStyle(color: Colors.black),
              ),
              content: const Text(
                'Are you sure you want to purchase this book?',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 137, 7, 7)),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Add to purchase
                    await purchaseCollection.add({
                      'userId': user.uid,
                      'bookId': bookId,
                      'purchase_date': FieldValue.serverTimestamp(),
                    });

                    // Update isPurchase field in books collection
                    await bookDoc.update({'isPurchase': true});

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'The purchase for ${widget.book.title} is Successful')));
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      } else {
        // Show confirmation dialog before removing from purchase
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Restore Purchase',
                style: TextStyle(color: Colors.black),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                      'Do you want to confirm the payment with the following card?',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 16.v),
                    Text(
                      'Card Number: ${card['cardNumber']}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Expiry Date: ${card['expiryDate']}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Card Holder: ${card['cardHolder']}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // Remove from purchase
                    await purchaseCollection
                        .doc(docSnapshot.docs.first.id)
                        .delete();

                    // Update isPurchase field in books collection
                    await bookDoc.update({'isPurchase': false});

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'The purchase for ${widget.book.title} is restored')));
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _fetchCreditCards() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('payments')
          .where('userId', isEqualTo: user?.uid)
          .get();
      setState(() {
        creditCards = querySnapshot.docs
            .map((doc) => (doc.data() as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, value.toString())))
            .toList();
      });
    } catch (e) {
      print('Failed to fetch credit cards: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            _buildMainContent(),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return RefreshIndicator(
      onRefresh: _fetchCreditCards,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 4.v,
            ),
            child: Column(
              children: [
                SizedBox(height: 24.v),
                _buildCardList(),
                SizedBox(height: 24.v),
                _buildAddNewCardButton(context),
                SizedBox(height: 24.v),
                _buildCardForm(),
                SizedBox(height: 24.v),
                _buildSubmitButton(context),
                SizedBox(height: 24.v),
                _buildRefreshButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "Credit Card Payment",
      ),
    );
  }

  Widget _buildCardList() {
    return Column(
      children: creditCards.map((card) {
        return InkWell(
          onTap: () => _showConfirmationDialog(context, card),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.v),
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 24.v,
            ),
            decoration: AppDecoration.fillPrimaryContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(card['cardNumber']!,
                        style:
                            CustomTextStyles.titleMediumAbhayaLibreExtraBold),
                    Text(card['expiryDate']!,
                        style: CustomTextStyles.labelLargePrimary),
                    Text(card['cardHolder']!,
                        style: CustomTextStyles.labelLargePrimary),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteCard(card),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _deleteCard(Map<String, String> card) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('payments')
          .where('cardNumber', isEqualTo: card['cardNumber'])
          .where('userId', isEqualTo: user?.uid)
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      setState(() {
        creditCards.remove(card);
      });
    } catch (e) {
      print('Failed to delete credit card: $e');
    }
  }

  Widget _buildAddNewCardButton(BuildContext context) {
    return CustomElevatedButton(
      height: 34.v,
      width: 200.h,
      text: "Add New Card",
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
      onPressed: () {
        setState(() {
          cardNumberController.clear();
          cardHolderController.clear();
          expiryDateController.clear();
          cvvController.clear();
        });
      },
    );
  }

  Widget _buildCardForm() {
    return Column(
      children: [
        CustomTextFormField(
          controller: cardNumberController,
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 49, 48, 48),
          ),
          hintText: "Card Number",
          textInputType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card number';
            }
            return null;
          },
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: cardHolderController,
          hintText: "Card Holder Name",
          textInputType: TextInputType.name,
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 49, 48, 48),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card holder name';
            }
            return null;
          },
        ),
        SizedBox(height: 16.v),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: expiryDateController,
                hintText: "Expiry Date (MM/YY)",
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 49, 48, 48),
                ),
                textInputType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 16.h),
            Expanded(
              child: CustomTextFormField(
                controller: cvvController,
                hintText: "CVV",
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 49, 48, 48),
                ),
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Submit",
      buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });

          final cardData = {
            'cardNumber':
                '**** **** **** ${cardNumberController.text.substring(cardNumberController.text.length - 4)}',
            'expiryDate': expiryDateController.text,
            'cardHolder': cardHolderController.text,
            'userId': user!.uid,
          };

          try {
            await _firestore.collection('payments').add(cardData);
            setState(() {
              creditCards.add(cardData);
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Card added successfully')),
            );
          } catch (e) {
            print('Failed to add card: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add card')),
            );
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
    );
  }

  Widget _buildRefreshButton() {
    return CustomElevatedButton(
      height: 34.v,
      width: 200.h,
      text: "Refresh",
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
      onPressed: _fetchCreditCards,
    );
  }

  // Future<void> _showConfirmationDialog(Map<String, String> card) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirm Payment'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               const Text(
  //                   'Do you want to confirm the payment with the following card?'),
  //               SizedBox(height: 16.v),
  //               Text('Card Number: ${card['cardNumber']}'),
  //               Text('Expiry Date: ${card['expiryDate']}'),
  //               Text('Card Holder: ${card['cardHolder']}'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Confirm'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Payment confirmed')),
  //               );
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
