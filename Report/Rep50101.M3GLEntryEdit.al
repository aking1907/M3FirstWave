report 50101 "M3 G/L Entry-Edit"
{
    Caption = 'M3 G/L Entry-Edit';
    Permissions = TableData "G/L Entry" = m;


    procedure GLEntryEdit(GLEntry: Record "G/L Entry")
    var
        GLE: Record "G/L Entry";
    begin
        GLE.Get(GLEntry."Entry No.");
        GLE.TestField(Amount, 0);
        GLE."Additional-Currency Amount" := 0;
        GLE."Add.-Currency Debit Amount" := 0;
        GLE."Add.-Currency Credit Amount" := 0;
        GLE.Modify(true);
    end;
}
