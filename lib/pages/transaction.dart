import 'package:dashboard_template/dummies/transaction.dart';
import 'package:dashboard_template/entities/transaction.dart';
import 'package:dashboard_template/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    Color appBarTextColor = ColorHelper.keepOrWhite(
        Theme.of(context).primaryColor,
        Theme.of(context).cardColor
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Transaction History",
          style: TextStyle(color: appBarTextColor),
        ),
      ),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    String? prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y")
        .format(DateTime.now().add(Duration(days: -1)));

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = transactions[index];
        DateTime date = DateTime.fromMillisecondsSinceEpoch(transaction.createdMillis);
        String dateString = DateFormat("EEE, MMM d, y").format(date);

        if (today == dateString) {
          dateString = "Today";
        } else if (yesterday == dateString) {
          dateString = "Yesterday";
        }

        bool showHeader = prevDay != dateString;
        prevDay = dateString;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (showHeader)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, Theme.of(context).cardColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  dateString,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            buildItem(context, date, transaction),
          ],
        );
      },
    );
  }

  Widget buildItem(BuildContext context, DateTime date, Transaction transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(width: 20),
          buildLine(context),
          Container(
            width: 92,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Text(
              DateFormat("hh:mm a").format(date),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(Transaction transaction, BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: transaction.point.isNegative
                ? [Colors.deepOrangeAccent, Colors.redAccent]
                : [Colors.greenAccent, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  transaction.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                NumberFormat("###,###,### P").format(transaction.point),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildLine(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
