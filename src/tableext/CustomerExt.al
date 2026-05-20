namespace DefaultPublisher;

using Microsoft.Sales.Customer;

tableextension 50002 CustomerExt extends Customer
{

    fields
    {



        field(5000; KRAPinDoc; Blob)
        {

            SubType = Bitmap;

        }
        field(5001; AtmDoc; Blob)
        {
            SubType = Bitmap;

        }

        field(5002; IdentityDocFront; Blob)
        {
            SubType = Bitmap;

        }

        field(5003; "KRA Pin"; Code[11])
        {

        }

        field(5004; "Id No."; Code[10])
        {

        }

        field(5005; "Passport No."; Code[20])
        {

        }

        field(5006; "ATM No."; Code[20])
        {

        }


        field(5007; IdentityDocBack; Blob)
        {

            SubType = Bitmap;

        }

    }

}