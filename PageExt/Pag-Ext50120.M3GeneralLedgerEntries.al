pageextension 50120 "M3 General Ledger Entries" extends "General Ledger Entries"
{
    actions
    {
        addafter(ReverseTransaction)
        {
            action(SetAdditionalAmounToZero)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Add. Amount to Zero';
                Ellipsis = true;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;

                trigger OnAction()
                var
                    GLEntryEdit: Report "M3 G/L Entry-Edit";
                    GLE: Record "G/L Entry";
                begin
                    CurrPage.SetSelectionFilter(GLE);
                    if GLE.FindSet() then
                        repeat
                            GLEntryEdit.GLEntryEdit(GLE);
                        until GLE.Next() = 0;
                    CurrPage.Update(False);
                    Message('Records updated successfully!');
                end;
            }
        }
    }
}
