page 50022 "Receipt Lines"
{
    ApplicationArea = Basic;
    PageType = ListPart;
    SourceTable = "Receipt Lines";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Transaction No."; Rec."Transaction No.")
                {

                }

                field("Account No."; Rec."Account No.")
                {

                }

                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }

                field("Project No."; Rec."Project No.")
                {

                }

                field("Unit No."; Rec."Unit No.")
                {

                }

                field(Amount; Rec.Amount)
                {

                }


                field(Description; Rec.Description)
                {

                }

            }
        }
    }
}