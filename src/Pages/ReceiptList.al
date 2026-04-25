page 50023 "Receipt List"
{
    PageType = List;
    ApplicationArea = Basic, Suite;
    SourceTable = "Receipt Header";
    Editable = False;
    CardPageId = "Receipt Header";

    layout
    {

        area(Content)
        {

            repeater(Control1)
            {

                field("No."; Rec."No.")
                {

                }

                field("Customer No."; Rec."Customer No.")
                {

                }

                field("Customer Name"; Rec."Customer Name")
                {

                }

                field(Amount; Rec.Amount)
                {

                }

                field("Posting Date"; Rec."Posting Date")
                {

                }
            }
        }
    }
}