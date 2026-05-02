Codeunit 50023 "Post-Customer Extension"
{

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;

    begin
        CustLedgerEntry.LockTable();

        CustLedgerEntry."Unit No." := GenJournalLine."Unit No.";
        CustLedgerEntry."Project No." := GenJournalLine."Project No.";
    end;



    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertGLEntry', '', false, false)]
    procedure InsertPropertyLedgerEntries(GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line")

    var
        PropertyLedgerEntries: Record "Prop. Ledger Entry";
        PropertyRec: Record Block;
        UnitRec: Record Unit;
    begin

        if GenJnlLine."Project No." <> '' then begin
            //PropertyLedgerEntries.LockTable();

            PropertyLedgerEntries.Init();
            PropertyLedgerEntries."Property No." := GenJnlLine."Project No.";

            //  PropertyLedgerEntries."Customer No." := GenJnlLine.acc

            PropertyLedgerEntries."Entry No." := GLEntry."Entry No.";
            PropertyLedgerEntries.Amount := GLEntry.Amount;
            PropertyLedgerEntries."Debit Amount" := GLEntry."Debit Amount";
            PropertyLedgerEntries."Credit Amount" := GLEntry."Credit Amount";

            PropertyLedgerEntries."Posting Date" := GLEntry."Posting Date";

            PropertyLedgerEntries."Document Type" := GLEntry."Document Type";
            PropertyLedgerEntries."Document No." := GLEntry."Document No.";
            PropertyLedgerEntries.Description := GLEntry.Description;


            UnitRec.Reset();

            UnitRec.SetRange("Block No", GenJnlLine."Project No.");
            UnitRec.SetRange(No, GenJnlLine."Unit No.");

            If UnitRec.FindFirst() then begin
                PropertyLedgerEntries."Unit No." := UnitRec.No;

            end;

            PropertyLedgerEntries.Insert();

        end;
    end;




}