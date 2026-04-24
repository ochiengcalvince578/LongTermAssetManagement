page 50018 "Employees Cue"
{
    PageType = CardPart;
    //ApplicationArea = All;
    SourceTable = "Employees Cue";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup("Employees")
            {
                field("All Employees"; Rec."All Employees")
                {

                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Employee List";

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