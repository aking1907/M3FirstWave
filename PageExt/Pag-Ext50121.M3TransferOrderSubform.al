pageextension 50121 "M3 Transfer Order Subform" extends "Transfer Order Subform"
{
    layout
    {
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
        LotNo: Code[30];
        LotCount: Integer;
    begin
        TS.SetRange("Source Type", Database::"Transfer Line");
        TS.SetRange("Source ID", Rec."Document No.");
        TS.SetRange("Source Ref. No.", Rec."Line No.");
        TS.SetFilter("Lot No.", '<>%1', '');
        LotCount += TS.Count();
        if TS.FindFirst() then
            LotNo := TS."Lot No.";   
        

        RE.SetRange("Source Type", Database::"Transfer Line");
        RE.SetRange("Source ID", Rec."Document No.");
        RE.SetRange("Source Ref. No.", Rec."Line No.");
        RE.SetFilter("Lot No.", '<>%1', '');
        LotCount += RE.Count();
        if RE.FindFirst() then 
            LotNo := RE."Lot No.";   

        if LotCount > 1 then
            exit('...');

        exit(LotNo);
    end;
}

