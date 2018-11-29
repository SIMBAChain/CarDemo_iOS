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

`Here <https://www.youtube.com/watch?v=1BatYaRD60c&list=PLgfX2jfDfJNMEqF_xjZBYmavONXeRK_q5>`_ is a playlist on the SIMBA Chain channel to get you up to speed on using the dashboard

Here is the Smart Contract I used for my CarDemo
************
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

