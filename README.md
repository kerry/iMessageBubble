# iMessageBubble
A sub class of UITableViewCell to create exactly the same kind of bubbles that iMessage uses in iOS 8. Very easy to use and highly customizable.

# Screenshots

![Alt text](screenshots/iMessageBubble%20screenshot.png "iMessageBubble Demo")

#Installation instructions

There are two ways to use this. One is to use the recommended way, i.e., the code and the other is to use XIB file. 

To use the code:

1. Register the class using the method "registerClass" of table view for each cell identifier (chatSend and chatReceive)
2. Then get the instance of the cell using the normal method like so:

<pre>
chatCell = (ChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
</pre>

To use XIB:

1. Register using the method "registerNib" of tableView for each cell identifier (chatSend and chatReceive)
2. Then get the instance of the cell using the normal method like so:

<pre>
chatCell = (ChatTableViewCellXIB *)[tableView dequeueReusableCellWithIdentifier:@"chatSend"];
</pre>


#NOTE

A sample fully working project is included.


If you liked the project, you may donate for the efforts through <a href="https://www.paypal.com/myaccount/transfer/buy/recipient">PayPal link</a> to prateekgrover.rns@gmail.com OR through <a href="https://play.google.com/store/apps/details?id=com.paytm.paywith">PayTM Wallet</a> (for Indian users) to prateekgrover.rns@gmail.com
