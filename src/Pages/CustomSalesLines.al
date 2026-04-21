page 50013 "Custom Sales Lines"
{
    ApplicationArea = All;
    SourceTable = "Custom Sales Lines";
    PageType = ListPart;


    layout
    {

        area(Content)
        {

            repeater(Control1)
            {

                field("Transaction No"; Rec."Transaction No") { }
                field("Property No"; Rec."Property No") { }

                field("Property Name"; Rec."Property Name") { }

                field(Unit; Rec."Unit No") { }

                field(Amount; Rec.Amount) { }

                field(Description; Rec.Description) { }

                field("GL Account"; Rec."GL Account") { }

            }

        }
    }
}