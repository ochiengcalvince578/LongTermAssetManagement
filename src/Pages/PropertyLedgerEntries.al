page 50028 "Property Ledger Entries"
{

    ApplicationArea = All;

    PageType = List;

    SourceTable = "Prop. Ledger Entry";

    Editable = false;

    layout
    {

        area(Content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {

                }

                field("Property No."; Rec."Property No.")
                {

                }

                field("Property Name"; Rec."Property Name")
                {

                }

                field("Customer No."; Rec."Customer No.") { }

                field("Customer Name."; Rec."Customer Name.") { }

                field(Amount; Rec.Amount) { }

                field("Credit Amount"; Rec."Credit Amount") { }

                field("Debit Amount"; Rec."Debit Amount") { }


                field("Posting Date"; Rec."Posting Date")
                {

                }
            }
        }
    }


}