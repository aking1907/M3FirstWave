pageextension 50115 "M3 Sales Order Subform Ext." extends "Sales Order Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        addafter(Quantity)
        {
            field("Lot No."; GetLotNo())
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    local procedure GetLotNo(): Code[30]
    var
        RE: Record "Reservation Entry";
        TS: Record "Tracking Specification";
        LotDictionary: Dictionary of [Code[50], Integer];
        LotNo: Code[30];
    begin
        TS.SetRange("Source Type", Database::"Sales Line");
        TS.SetRange("Source ID", Rec."Document No.");
        TS.SetRange("Source Ref. No.", Rec."Line No.");
        TS.SetFilter("Lot No.", '<>%1', '');
        if TS.FindSet() then repeat
            if LotNo = '' then 
                LotNo := TS."Lot No.";
            if not LotDictionary. ContainsKey(TS."Lot No.") then
                LotDictionary.Add(TS."Lot No.", 1);
        until TS.Next() = 0;
        

        RE.SetRange("Source Type", Database::"Sales Line");
        RE.SetRange("Source ID", Rec."Document No.");
        RE.SetRange("Source Ref. No.", Rec."Line No.");
        RE.SetFilter("Lot No.", '<>%1', '');
        if RE.FindSet() then repeat
            if LotNo = '' then 
                LotNo := RE."Lot No.";
            if not LotDictionary. ContainsKey(RE."Lot No.") then
                LotDictionary.Add(RE."Lot No.", 1);
        until RE.Next() = 0; 

        if LotDictionary.Count > 1 then
            exit('...')
        else if LotDictionary. Count = 1 then
            exit(LotNo)
        else
            exit('');
    end;
}
