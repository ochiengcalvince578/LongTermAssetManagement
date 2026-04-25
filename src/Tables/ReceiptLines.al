table 50020 "Receipt Lines"
{
    fields
    {


        field(1; "Transaction No."; Code[20])
        {

        }

        field(5; "Account No."; Code[20])
        {

            // TableRelation = "G/L Account";
            TableRelation = Customer;

        }


        // field(2; "Customer No."; Code[20])
        // {

        //     TableRelation = Customer;

        //     trigger OnValidate()
        //     var
        //         CustomerRec: Record Customer;
        //     begin

        //         CustomerRec.Reset();
        //         CustomerRec.SetRange("No.", "Customer No.");

        //         if CustomerRec.FindFirst() THEN
        //             "Customer Name" := CustomerRec.Name;

        //     end;
        // }

        field(3; "Customer Name"; Text[100])
        {

            Editable = false;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;

            begin

                CustomerRec.Reset();

                CustomerRec.SetRange("No.", "Account No.");

                If CustomerRec.FindFirst() then
                    "Customer Name" := CustomerRec.Name;


            end;

        }

        field(4; Amount; Decimal)
        {

        }


        field(6; "Account Name"; Text[100])
        {

        }

        field(7; Description; Text[100])
        {

        }

        field(8; "Project No."; Code[20])
        {

            TableRelation = Block;

        }

        field(9; "Unit No."; Code[20])
        {

            TableRelation = Unit where("Block No" = field("Project No."), Status = Const(Active));

        }


    }
}