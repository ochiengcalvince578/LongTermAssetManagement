page 50029 "Property Posting Group"
{
    ApplicationArea = All;

    PageType = List;

    SourceTable = "Property Posting Group";

    layout
    {

        area(Content)
        {
            repeater(Control1)
            {
                field(No; Rec.No)
                {

                    Caption = 'Code';

                }

                field(Description; Rec.Description)
                {

                }

                field("Inventory Account"; Rec."Inventory Account")
                {

                }
            }
        }
    }
}