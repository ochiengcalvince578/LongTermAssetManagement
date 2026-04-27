namespace DefaultPublisher;

page 50004 "Block Card"
{

    ApplicationArea = Suite;
    Caption = 'Housing Card';
    SourceTable = Block;

    layout
    {

        area(content)
        {

            group(General)
            {

                field(No; Rec.No)
                {

                }

                field(Description; Rec.Description)
                {

                }

                field(Location; Rec.Location)
                {

                }

                field(Units; Rec.Units)
                {

                }

            }

            group("Unit Information")
            {
                // field("Unit Cost"; Rec."Unit Cost")
                // {

                // }

                // field("Electricity Charge Per Unit"; Rec."Electricity Charge Per Unit")
                // {

                // }

                // field("Water Charge Per Unit"; Rec."Water Charge Per Unit")
                // {

                // }


                // field("Service Charge Per Unit"; Rec."Service Charge Per Unit")
                // {

                // }

                // field("Legal Expense Per Unit"; Rec."Legal Expense Per Unit")
                // {

                // }


                field(Townhouses; Rec.Townhouses)
                {

                }

                field("Two - Bedroom Units"; Rec."Two - Bedroom Units")
                {

                }

                field("Three - Bedroom Units"; Rec."Three - Bedroom Units")
                {

                }


            }


            group("Unit Cost Information")
            {

                group("Townhouses Cost")
                {

                    Caption = 'Townhouses';

                    field("Townhouse Cost"; Rec."Townhouse Cost")
                    {



                    }

                    field("Electricity Charge Townhouse"; Rec."Electricity Charge Townhouse")
                    {

                        Caption = 'Elecricity Charge';

                    }

                    field("Water Charge Townhouse"; Rec."Water Charge Townhouse")
                    {

                        Caption = 'Water Charge';

                    }

                    field("Legal Charge Townhouse"; Rec."Legal Charge Townhouse")
                    {
                        Caption = 'Legal Charge';

                    }
                }


                group("Two - Bedroom Costs")
                {
                    Caption = 'Two - Bedrooms';


                    field("Two - Bedroom Cost"; Rec."Two - Bedroom Cost")
                    {

                    }

                    field("Electricity Charge 2b"; Rec."Electricity Charge 2b")
                    {
                        Caption = 'Electricity Charge';

                    }

                    field("Water Charge 2b"; Rec."Water Charge 2b")
                    {
                        Caption = 'Water Charge';
                    }

                    field("Legal Charge 2b"; Rec."Legal Charge 2b")
                    {
                        Caption = 'Legal Charge';
                    }

                }


                group("Three Bedrooms")
                {



                    field("Three - Bedroom Cost"; Rec."Three - Bedroom Cost")
                    {

                    }

                    field("Electricity Charge 3b"; Rec."Electricity Charge 3b")
                    {

                        Caption = 'Electricty Charge';

                    }

                    field("Water Charge 3b"; Rec."Water Charge 3b")
                    {
                        Caption = 'Water Charge';


                    }

                    field("Legal Charge 3b"; Rec."Legal Charge 3b")
                    {
                        Caption = 'Legal Charge';

                    }

                }

            }


            group("General Ledger Setup")
            {

                field("Inventory Account"; Rec."Inventory Account")
                {

                    ShowMandatory = true;

                }

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {

                    ShowMandatory = true;

                }

                field("Income Account"; Rec."Income Account")
                {
                    ShowMandatory = true;
                }
            }
        }
    }


    actions
    {


        area(Processing)
        {

            action("Generate Units")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                var

                begin
                    GenerateUnits();
                    Message('Units created successfully');
                end;
            }

            action("Property Units")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()

                var
                    UnitRec: Record Unit;
                begin

                    UnitRec.Reset();
                    UnitRec.SetRange("Block No", Rec.No);
                    //if UnitRec.FindFirst() then
                    Page.Run(50007, UnitRec);
                end;
            }
        }


        area(Reporting)
        {

            action("Portfolio")
            {

                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;


                trigger OnAction()

                var
                    ProjectRec: Record Block;

                begin

                    ProjectRec.Reset();

                    ProjectRec.SetRange(No, Rec.No);

                    If ProjectRec.FindFirst() then begin

                        Report.Run(50023, true, false, ProjectRec);
                    end;
                end;

            }
        }
    }


    // local procedure GenerateUnits()

    // VAR
    //     uNIT: rECORD uNIT;
    //     Blocks: Record Block;
    //     i: Integer;
    //     iFinal: Integer;

    // begin


    //     for i := 1 to Rec.Townhouses do begin

    //         Rec.TestField(Townhouses);
    //         Rec.TestField("Legal Charge Townhouse");
    //         Rec.TestField("Electricity Charge Townhouse");
    //         Rec.TestField("Water Charge Townhouse");

    //         Rec.TestField("Townhouse Cost");

    //         uNIT.Init();

    //         Unit.No := Format(i);
    //         Unit."Block No" := Rec.No;
    //         Unit.Price := REC."Townhouse Cost";
    //         Unit."Electricity Charge" := rEC."Electricity Charge Townhouse";

    //         Unit."Water Charge" := rEC."Water Charge Townhouse";

    //         //Unit."Service Charge" := Rec."Service Charge Per Unit";

    //         uNIT."Legal Expense" := Rec."Legal Charge Townhouse";

    //         Unit.Insert();

    //         iFinal := i;
    //     end;


    //     for i := iFinal to Rec."Two - Bedroom Units" do begin

    //         Rec.TestField("Two - Bedroom Units");
    //         Rec.TestField("Legal Charge 2b");
    //         Rec.TestField("Electricity Charge 2b");
    //         Rec.TestField("Water Charge 2b");

    //         Rec.TestField("Two - Bedroom Cost");

    //         uNIT.Init();

    //         Unit.No := Format(i);
    //         Unit."Block No" := Rec.No;
    //         Unit.Price := REC."Two - Bedroom Cost";
    //         Unit."Electricity Charge" := rEC."Electricity Charge 2b";

    //         Unit."Water Charge" := rEC."Water Charge 2b";

    //         //Unit."Service Charge" := Rec."Service Charge Per Unit";

    //         uNIT."Legal Expense" := Rec."Legal Charge 2b";

    //         Unit.Insert();

    //         iFinal := i;
    //     end;


    //     for i := iFinal to Rec."Three - Bedroom Units" do begin


    //         Rec.TestField("Three - Bedroom Units");
    //         Rec.TestField("Legal Charge 3b");
    //         Rec.TestField("Electricity Charge 3b");
    //         Rec.TestField("Water Charge 3b");

    //         Rec.TestField("Three - Bedroom Cost");

    //         uNIT.Init();

    //         Unit.No := Format(i);
    //         Unit."Block No" := Rec.No;
    //         Unit.Price := REC."Three - Bedroom Cost";
    //         Unit."Electricity Charge" := rEC."Electricity Charge 3b";

    //         Unit."Water Charge" := rEC."Water Charge 3b";

    //         //Unit."Service Charge" := Rec."Service Charge Per Unit";

    //         uNIT."Legal Expense" := Rec."Legal Charge 3b";

    //         Unit.Insert();
    //     end;

    // end;

    local procedure GenerateUnits()
    var
        Unit: Record Unit;
        ExistingUnit: Record Unit;

        NextNo: Integer;

        UnitEmu: Record Unit;
    begin
        // Validate all fields before any loop
        Rec.TestField(Townhouses);
        Rec.TestField("Legal Charge Townhouse");
        Rec.TestField("Electricity Charge Townhouse");
        Rec.TestField("Water Charge Townhouse");
        Rec.TestField("Townhouse Cost");

        Rec.TestField("Two - Bedroom Units");
        Rec.TestField("Legal Charge 2b");
        Rec.TestField("Electricity Charge 2b");
        Rec.TestField("Water Charge 2b");
        Rec.TestField("Two - Bedroom Cost");

        Rec.TestField("Three - Bedroom Units");
        Rec.TestField("Legal Charge 3b");
        Rec.TestField("Electricity Charge 3b");
        Rec.TestField("Water Charge 3b");
        Rec.TestField("Three - Bedroom Cost");


        ExistingUnit.SetRange("Block No", Rec.No);
        if not ExistingUnit.IsEmpty() then
            // Error('Units have already been generated for block %1. Delete existing units first.', Rec.No)
            ExistingUnit.DeleteAll();

        NextNo := 1;

        // Townhouses
        repeat
            InsertUnit(Unit, Unit.Type::Townhouse, NextNo, Rec.No, Rec."Townhouse Cost",
                Rec."Electricity Charge Townhouse", Rec."Water Charge Townhouse",
                Rec."Legal Charge Townhouse");
            NextNo += 1;
        until NextNo > Rec.Townhouses;

        // Two-Bedroom Units
        repeat
            InsertUnit(Unit, Unit.Type::TwoBedroom, NextNo, Rec.No, Rec."Two - Bedroom Cost",
                Rec."Electricity Charge 2b", Rec."Water Charge 2b",
                Rec."Legal Charge 2b");
            NextNo += 1;
        until NextNo > Rec.Townhouses + Rec."Two - Bedroom Units";

        // Three-Bedroom Units
        repeat
            InsertUnit(Unit, Unit.Type::ThreeBedroom, NextNo, Rec.No, Rec."Three - Bedroom Cost",
                Rec."Electricity Charge 3b", Rec."Water Charge 3b",
                Rec."Legal Charge 3b");
            NextNo += 1;
        until NextNo > Rec.Townhouses + Rec."Two - Bedroom Units" + Rec."Three - Bedroom Units";
    end;

    local procedure InsertUnit(
        var Unit: Record Unit;
        UnitType: Option;
        No: Integer;
        BlockNo: Code[20];
        Price: Decimal;
        ElectricityCharge: Decimal;
        WaterCharge: Decimal;
        LegalExpense: Decimal)
    begin
        Unit.Init();
        Unit.No := Format(No);
        Unit.Type := UnitType;
        Unit."Block No" := BlockNo;
        Unit.Price := Price;
        Unit."Electricity Charge" := ElectricityCharge;
        Unit."Water Charge" := WaterCharge;
        Unit."Legal Expense" := LegalExpense;
        Unit.Insert(true);
    end;

}

