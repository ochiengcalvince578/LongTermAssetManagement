page 50015 "Customers Cue"
{
    PageType = CardPart;
    //ApplicationArea = All;
    SourceTable = "Customers Cue";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup("Customers")
            {
                field("All Customers"; Rec."All Customers")
                {

                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Customer List";

                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}