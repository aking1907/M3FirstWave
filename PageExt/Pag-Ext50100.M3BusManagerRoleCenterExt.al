pageextension 50100 "M3 BM Role Center Ext." extends "Business Manager Role Center"
{
    actions
    {
        addlast(Action41)
        {
            action("Purch. Proforma Invoices")
            {
                RunObject = page "M3 Purchase Proforma Invoices";
                ApplicationArea = All;
            }
        }
    }

}
