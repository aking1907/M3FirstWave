pageextension 50108 "M3 Purch. & Pay. Setup Ext." extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Invoice Nos.")
        {
            field("Proforma Invoice Nos."; Rec."Proforma Invoice Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}
