.. figure:: Simba-NS.png
   :align:   center
   
******************
SIMBA CarDemo iOS
******************
 
Installation
==============


* Hit the "Clone or Download" button in upper right corner of the github page
* Hit the "Open in Xcode" button.
* Hit the "Open Xcode" button on the popup.
* Choose where you want to save the project and hit clone.
* Xcode should open the project.

Using SIMBA Chain
==============

`Here <https://www.youtube.com/watch?v=1BatYaRD60c&list=PLgfX2jfDfJNMEqF_xjZBYmavONXeRK_q5>`_ is a playlist on the SIMBA Chain Youtube channel to get you up to speed on using the dashboard.

.. _contract:
Smart Contract
************

Here is the smart contract I used for iOS

.. code-block:: python

   contract Application {
    function Application() public {}

    function carSale (
        string soldTo,
        string amount,
        string _bundleHash
    )
    public {}

    function registerCar (
        string VIN,
        string Make,
        string Model,
        string _bundleHash
    )
    public {}

    function accidentReport (
        string report_name,
        string _bundleHash
    )
    public {}
    }


.. _dashboard:
Creating an app on the SIMBA Dashboard
***************
Before Starting make sure you have an account on the Simba Dashboard and an Ethereum wallet with Ether in it on the Rinkeby testnet

* Create The Smart Contract
* Create The Application
* Configure The Application(Ethereum Blockchain, Rinkeby Network,IPFS Filesystem, Permission disabled)
* Generate API Key(This is not the API name)
.. figure:: APIKey.png
   :align:   center
Converting the Cardemo example to your app
***************
* Update URL
   * Line 10 APIs.swift in swaggers
   * Line 158 PostRegistrationViewController.swift
   * Line 209 PostRegistrationViewController.swift
   .. note:: The only part of the URL you need to change is "ioscardemo2" with whatever you chose for your app's API name(not the name of your apikey)
* Update API Key
   * Line 13 APIs.swift in swaggers
   * Line 160 PostRegistrationViewController.swift
   * Line 207 PostRegistrationViewController.swift


