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

        field(12; "Responsible Employee"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()

            var

                EmployeeRec: Record Employee;

            begin


                EmployeeRec.Reset();

                EmployeeRec.SetRange("No.", "Responsible Employee");

                if EmployeeRec.FindFirst() then
                    "Responsible Employee Name" := EmployeeRec."Search Name";


            end;
        }

        field(13; "Bank Account Code"; Code[20])
        {

            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                BankAccountRec: Record "Bank Account";
            begin

                BankAccountRec.Reset();
                BankAccountRec.SetRange("No.", "Bank Account Code");

                If BankAccountRec.FindFirst() then begin

                    "Bank Account Name" := BankAccountRec.Name;

                end;

            end;

        }

        field(14; "Bank Account Name"; Text[50])

        {

        }

        field(15; "Repayment Period"; Option)
        {
            OptionMembers = "Monthly","Daily","Annually";
            InitValue = "Monthly";

        }

        field(16; "Installments"; Integer)
        {

        }

        // Interest Rate
        field(17; "Interest Rate"; Decimal)
        {

        }

        field(18; "Unit No."; Code[20])
        {

            //TableRelation = Unit;
            TableRelation = Unit where("Block No" = field("Project No"), Status = const(Available));

        }

        field(19; "Responsible Employee Name"; Text[100])
        {
            Editable = FALSE;
        }

    }

    trigger OnInsert()

    begin

        "No" := NoSeriesMgmt.GetNextNo('SALE');
    end;

    var

        NoSeriesMgmt: Codeunit "No. Series";

}