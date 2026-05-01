table 50019 "Receipt Header"
{
    fields
    {

        field(1; "No."; Code[20])
        {

        }

        field(2; "Customer No."; Code[20])
        {

            TableRelation = Customer;

            trigger OnValidate()
            var

                CustomerRec: Record Customer;


            begin

                CustomerRec.Reset();
                CustomerRec.SetRange("No.", "cUSTOMER No.");

                iF CustomerRec.FindFirst() THEN BEGIN
                    "Customer Name" := CustomerRec.Name;
                END
            end;

        }

        field(3; "Customer Name"; Text[100])
        {

        }

        field(4; "Bank Account No"; Code[20])
        {
            TableRelation = "Bank Account";
        }

        field(5; Reference; Text[100])
        {

        }

        field(6; Amount; Decimal)
        {

        }

        field(7; "Posting Date"; Date)
        {

        }

        field(8; Posted; Boolean)
        {

        }
    }


    Keys
    {
        Key(PKey; "No.")
        {

        }
    }

    trigger OnInsert()
    begin

        "No." := NoSeriesMgmt.GetNextNo('RCPT');
    end;

    var

        NoSeriesMgmt: Codeunit "No. Series";
}