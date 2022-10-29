This is a flutter sdk for implementing WayaPay payment gateway

## Get Started

This Javascript library provides a wrapper to implement WayaPay Payment to your application via CDN
### Usage

This library can be implemented into your application via CDN using Javascript or JQuery

### Script Source
#### Production : 
#### Test: 

### Sample Function Request and Responses

#### Request for calling InitializePayment function.

To initialize the transaction, you'll need to pass information such as email, customer object, amount,merchantId, wayaPublicKey, etc. Email and amount,merchantId,description, wayaPublicKey are required. You can also pass any other additional information in the metadata object field. Here is the full list of parameters you can pass:
|Param       | Type                 | Default    | Required | Description                      
| :------------ | :------------------- | :--------- | :------- | :-------------------------------------------------
| amount	| `string`			   | undefined      | `true`  | Amount you want to debit customer e.g 1000.00, 10.00...
| description      | `string`             | undefined   | `true`  | description of the transaction
| email | `string`             | undefined       | `true`  | Email address of customer
| wayaPublicKey       | `string`        | undefined | `true`  | Your public key from wayaPay.
| currency      | `number`  |  `NGN`    | `false`   | Currency charge should be performed in. Allowed only `566`.
| merchantId      | `string`  |  undefined    | `true`   | merchant unique identification.
| mode      | `string`  |  `Debug`    | `true`   | Allowed values are `Debug` or `Live`.
| customer      | `object`  |  `undefined`    | `true`   | this includes `name`(requred) , `email`(required) and `phoneNumber`(optional) of the customer.

 """
 Charge charge = Charge(
                            amount: 200,
                            isTest: true,
                            description:"mobile payment",
                            customer: Customer(
                            name: "", 
                            email: "", 
                            phoneNumber: ""
                   
                          ),
                            merchantId: '<YOUR MAERCHANTID>',
                            wayaPublicKey: "<YOUR WAYAPAY>"
                        );
 """
                        
                        
#### Response from calling checkout function
|Param       | Type                 | Description                      
| :------------ | :------------------- | :-------------------------------------------------
| success	| `boolean`			 | Shows whether the intialise payment function call was successful or not
| message | `string`  | description of the response data



