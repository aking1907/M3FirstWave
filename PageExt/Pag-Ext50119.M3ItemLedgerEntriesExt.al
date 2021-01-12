pageextension 50119 "M3 Item Ledger Entries Ext." extends "Item Ledger Entries"
{
    layout
    {
        addafter("Cost Amount (Actual)")
        {
            field("Remaining Cost Amount (Actual)"; Rec.GetRemCostAmountActual())
            {
                AutoFormatType = 1;
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}
