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

}