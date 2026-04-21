table 50005 Unit
{

    fields
    {

        field(1; No; Code[20])
        {

        }




        field(2; Price; Decimal)
        {

        }

        field(3; "Water Charge"; Decimal)
        {

        }

        field(4; "Electricity Charge"; Decimal)
        {

        }

        field(5; "Unit No"; Code[50])
        {

        }

        field(6; Type; Option)
        {

            OptionMembers = Townhouse,ThreeBedroom,OneBedroom,TwoBedroom;
            OptionCaption = 'Townhouse, 3 Bedroom, 1 Bedroom, 2 Bedroom';
        }

        field(7; "Service Charge"; Decimal)
        {

        }

        field(8; "Legal Expense"; Decimal)
        {

        }


        field(9; "Block No"; Code[20])
        {

            Editable = false;

        }




    }

}