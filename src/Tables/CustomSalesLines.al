table 50013 "Custom Sales Lines"
{
    fields
    {


        field(1; "Transaction No"; Code[20])
        {

        }

        field(2; "Amount"; Decimal)
        {

        }

        field(3; "Property No"; Code[20])
        {

            TableRelation = Block;

            trigger OnValidate()

            var

                BlockRec: Record Block;

            begin

                BlockRec.Reset();

                BlockRec.SetRange(No, "Property No");

                if BlockRec.FindFirst() then begin

                    "Property Name" := BlockRec.Description;
                end

            end;
        }

        field(4; "Property Name"; Text[100])
        {

            Editable = FALSE;

        }


        field(5; "Unit No"; Code[20])
        {
            TableRelation = Unit WHERE("Block No" = FIELD("Property No"));
            //TableRelation = Unit;

            trigger OnValidate()

            var

                SalesLines: Record "Custom Sales Lines";
                UnitRec: Record Unit;

            begin

                UnitRec.Reset();
                UnitRec.SetRange(No, "Unit No");

                If UnitRec.FindFirst() then begin
                    Amount := UnitRec.Price;


                    // for each charge create a new line maybe??
                end;



                //SalesLines.Reset();

                // SalesLines.Init();



            end;
        }

        field(7; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }


        field(8; "Description"; Text[100])

        {

        }

    }
}