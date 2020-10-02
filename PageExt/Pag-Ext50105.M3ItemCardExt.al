pageextension 50105 "M3 Item Card Ext." extends "Item Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Abbreviation Code"; "Abbreviation Code")
            {
                ApplicationArea = All;
            }
            field(Size; Size)
            {
                ApplicationArea = All;
            }
        }
    }
}
