table 50011 "Custom Sales Header"
{


    fields
    {

        field(1; "No"; Code[20]) { }

        field(2; "Purchase Option"; Option)
        {

            OptionMembers = "Rent To Own","Cash Deposit","Outright Sale";
        }

        field(3; "Customer No"; Code[30])
        {
            TableRelation = Customer;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin

                CustomerRec.Reset;
                If CustomerRec.Get("Customer No") then
                    "Customer Name" := CustomerRec.Name;
            end;
        }

        field(4; "Customer Name"; Text[100])
        {

            Editable = False;

        }



        field(7; "Amount"; Decimal)
        {

        }

        field(8; "Posting Date"; Date)
        {

        }

        field(9; Posted; Boolean)
        {

        }


        field(10; "Project No"; Code[20])
        {

            TableRelation = Block;

            trigger OnValidate()
            var

                BlockRec: Record Block;

            begin

                BlockRec.Reset();
                BlockRec.SetRange(No, "Project No");

                If BlockRec.FindFirst() then
                    "Project Name" := BlockRec.Description;



            end;
        }

        field(11; "Project Name"; Text[100])
        {

        }



    }

}