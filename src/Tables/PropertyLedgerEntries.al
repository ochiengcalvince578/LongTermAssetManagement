
table 50024 "Prop. Ledger Entry"
{
    Caption = 'Prop. Ledger Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
        }

        field(2; "Property No."; Code[20])
        {


            trigger OnValidate()

            var

                ProjectRec: Record Block;

            begin

                ProjectRec.Reset();

                ProjectRec.SetRange(No, "Property No.");

                If ProjectRec.FindFirst() then begin

                    "Property Name" := ProjectRec.Description;
                end

            end;

        }

        field(3; "Property Name"; Text[100])
        {

            Editable = false;
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            ToolTip = 'Specifies the customer account number that the entry is linked to.';

            trigger OnValidate()

            var

                CustomerRec: Record Customer;

            begin

                CustomerRec.Reset();

                CustomerRec.SetRange("No.", "Customer No.");

                If CustomerRec.FindFirst() then
                    "Customer Name." := CustomerRec.Name;



            end;


        }

        field(5; "Customer Name."; Text[100])
        {

            Editable = false;



        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the customer entry''s posting date.';
        }
        field(7; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type that the customer entry belongs to.';
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the entry''s document number.';

            trigger OnLookup()
            var
                IncomingDocument: Record "Incoming Document";
            begin
                IncomingDocument.HyperlinkToDocument("Document No.", "Posting Date");
            end;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies a description of the customer entry.';
        }

        field(10; "Reference"; Text[35])
        {
            Caption = 'Reference';
            ToolTip = 'Specifies the customer''s reference.';
        }

        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            ToolTip = 'Specifies the amount of the entry.';
        }


        field(12; "Property Posting Group"; Code[20])
        {
            Caption = 'Property Posting Group';
            TableRelation = "Property Posting Group";
            ToolTip = 'Specifies the propertys''s market type to link business transactions to.';
        }

        field(13; "Responsible Employee No."; Code[20])
        {

        }

        field(14; "Responsible Employee Name"; Text[100])
        {

        }


        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
        }

        field(16; "Debit Amount"; Decimal)
        {

        }

        field(17; "Credit Amount"; Decimal)
        {

        }

        field(18; "Unit No."; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }



}

