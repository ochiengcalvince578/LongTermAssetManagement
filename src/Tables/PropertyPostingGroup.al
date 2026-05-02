table 50025 "Property Posting Group"
{
    fields
    {
        field(1; No; Code[20]) { }

        field(2; Description; Text[100])
        {

        }

        field(3; "Inventory Account"; Code[20])
        {
            Caption = 'Inventory/WIP Account';
            TableRelation = "G/L Account";
        }
    }
}