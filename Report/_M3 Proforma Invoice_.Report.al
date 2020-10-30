report 50100 "M3 Proforma Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/ProformaInvoice.rdl';
    Caption = 'Proforma Invoice';
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem(ProfInvHeader; "M3 Proforma Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Proforma Invoice';
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column("Address2"; CompanyInfo."Address 2")
            {
            }
            column(ShortAddress; ShortAddress)
            {
            }
            column(CountryName; Country.Name)
            {
            }
            column(Phone; CompanyInfo."Phone No.")
            {
            }
            column(PhoneLbl; PhoneLbl)
            {
            }
            column(Fax; CompanyInfo."Fax No.")
            {
            }
            column(FaxLbl; FaxLbl)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(EmailLbl; EmailLbl)
            {
            }
            column(HomePage; CompanyInfo."Home Page")
            {
            }
            column(HttpLbl; HttpLbl)
            {
            }
            column(VATNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(VATNoLbl; VATNoLbl)
            {
            }
            column(TotalAmountText; TotalAmountText)
            {
            }
            column(FooterText; FooterText)
            {
            }
            column(ProformaNo; "No.")
            {
            }
            column(ProformaInvoiceNoLbl; ProformaInvoiceNoLbl)
            {
            }
            column(ProformaDate; StrSubstNo('%1%2', DateLbl, format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>')))
            {
            }
            column(DateLbl; DateLbl)
            {
            }
            column(ShipperLbl; ShipperLbl)
            {
            }
            column(ShipperDesc; "Shipper Desc")
            {
            }
            column(ConsigneeLbl; ConsigneeLbl)
            {
            }
            column(ConsigneeDesc; "Consignee Desc")
            {
            }
            column(LoadingPointLbl; LoadingPointLbl)
            {
            }
            column(LoadingPointDesc; "Loading Point Desc")
            {
            }
            column(ContainersLbl; ContainersLbl)
            {
            }
            column(ContainersDesc; ContainersDesc)
            {
            }
            column(DeliveryPointLbl; DeliveryPointLbl)
            {
            }
            column(DeliveryPointDesc; "Delivery Point Desc")
            {
            }
            column(DeliveryBasisLbl; DeliveryBasisLbl)
            {
            }
            column(DeliveryBasisDesc; "Delivery Basis")
            {
            }
            column(DocumentBasis; "Delivery Basis Desc")
            {
            }
            dataitem(LotNoInfo; "Lot No. Information")
            {
                DataItemLink = "Proforma Invoice No." = field("No.");
                DataItemLinkReference = ProfInvHeader;
                column(ItemDesc; "Item Desc")
                {
                }
                column(ContainerLbl; ContainerLbl)
                {
                }
                column(ContainerName; "Container No.")
                {
                }
                column(PureContentLbl; PureContentLbl)
                {
                }
                column(PureContent; format("Pure Content, %", 0, '<Sign><Integer><Decimals,5>') + ' %')
                {
                }
                column(PriceLbl; PriceLbl)
                {
                }
                //column(PriceNet; StrSubstNo('%1 %2', format("Price Net", 0, '<Sign><Integer><Decimals,3>'), "Currency Code"))
                column(Price; StrSubstNo('%1%2/%3 pure = %1%4/%3 %5', "Currency Code", format("Price Gross", 0, '<Sign><Integer><Decimals,3>'), "Unit of Measure Code", format("Price Net", 0, '<Sign><Integer><Decimals,3>'), "Item Abbreviation Code"))
                {
                }
                column(WeightNetLbl; WeightNetLbl)
                {
                }
                column(NetWeight; format("Weight Net", 0, '<Sign><Integer><Decimals,4>') + ' ' + "Unit of Measure Code")
                {
                }
                column(WeightGrossLbl; WeightGrossLbl)
                {
                }
                column(GrossWeight; format("Weight Gross", 0, '<Sign><Integer><Decimals,4>') + ' ' + "Unit of Measure Code")
                {
                }
                column(SizeLbl; SizeLbl)
                {
                }
                column(Size; Size)
                {
                }
                column(OriginLbl; OriginLbl)
                {
                }
                column(Origin; GetCountryName(Origin))
                {
                }
                column(SubtotalLbl; SubtotalLbl)
                {
                }
                column(Subtotal; StrSubstNo('%1 %2', format(Subtotal, 0, '<Sign><Integer><Decimals,3>'), "Currency Code"))
                {
                }
                column(ProducerLbl; ProducerLbl)
                {
                }
                column(ProducerDesc; "Producer Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ContainersDesc := GetListOfContainers();
                    TotalAmountText := GetTotalAmountText();
                end;
            }

            trigger OnPreDataItem()
            begin
                ContainersDesc := GetListOfContainers();
                TotalAmountText := GetTotalAmountText();
                FooterText := StrSubstNo(FooterTextLbl,
                                         CompanyInfo.Address,
                                         CompanyInfo."Ship-to Address 2",
                                         ShortAddress,
                                         Country.Name,
                                         PhoneLbl + CompanyInfo."Phone No.",
                                         FaxLbl + CompanyInfo."Fax No."
                                        );
            end;

        }
    }

    var
        ShortAddress: Text[100];
        ContainersDesc: Text[250];
        TotalAmountText: Text[250];
        OnesText: Array[20] of Text[30];
        TensText: Array[10] of Text[30];
        ThousText: array[5] of Text[30];
        //records
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Country: Record "Country/Region";
        ReportCheck: Report Check;
        FooterText: Text[250];
        //lables
        PhoneLbl: Label 'Phone';
        FaxLbl: Label 'Fax';
        EmailLbl: Label 'E-mail';
        HttpLbl: Label 'Http';
        VATNoLbl: Label 'VAT №';
        ProformaInvoiceNoLbl: Label 'PROFORMA INVOICE №';
        DateLbl: Label 'Date:';
        ShipperLbl: Label 'Shipper:';
        ProducerLbl: Label 'Producer:';
        ConsigneeLbl: Label 'Consignee:';
        LoadingPointLbl: Label 'Loading point:';
        ContainersLbl: Label 'Containers:';
        DeliveryPointLbl: Label 'Delivery point:';
        DeliveryBasisLbl: Label 'Delivery basis:';
        ContainerLbl: label 'Container:';
        PureContentLbl: Label 'Pure content:';
        PriceLbl: Label 'Price:';
        WeightNetLbl: Label 'Weight net:';
        WeightGrossLbl: Label 'Weight gross:';
        SizeLbl: Label 'Size';
        OriginLbl: Label 'Origin:';
        SubtotalLbl: Label 'Subtotal';
        ErrInputData: Label 'Error input data!';
        TotalAmountTextLbl: Label 'Total sum %1 %2 (%3 and %4) shall not be paid and is given for customs purposes only. Property of %5.';
        FooterTextLbl: Label '%1 - %2 - %3 - %4 - %5 - %6';

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        Country.Get(CompanyInfo."Country/Region Code");
        ShortAddress := StrSubstNo('%1-%2 %3', CompanyInfo."Country/Region Code", CompanyInfo."Post Code", CompanyInfo.City);
    end;

    local procedure GetCountryName(CountryISOCode: Code[10]): Text[40]
    var
        Country: Record "Country/Region";
    begin
        if Country.Get(CountryISOCode) then exit(Country.Name);
        exit('');
    end;

    local procedure GetListOfContainers(): Text
    var
        ListOfContainers: Text;
        Lot: Record "Lot No. Information";
    begin
        Lot.SetRange("Proforma Invoice No.", ProfInvHeader."No.");
        if Lot.FindSet() then
            repeat
                ListOfContainers += Lot."Container No." + ',';
            until Lot.Next() = 0;
        exit(DelChr(ListOfContainers, '<>', ','));
    end;

    local procedure GetTotalAmountText(): Text[250]
    var
        Lot: Record "Lot No. Information";
        PIH: Record "Purch. Inv. Header";
        Currency: Record Currency;
        CurrencyCode: Code[5];
        CurrNoteName: Text[50];
        CurrCoinName: Text[50];
        CurBigValueStr: Text[150];
        CurSmallValueStr: Text[150];
        TextArray: Array[2] of Text[80];
        TotalAmount: Decimal;
    begin
        Lot.SetRange("Proforma Invoice No.", ProfInvHeader."No.");
        if Lot.IsEmpty then exit('');
        if Lot.FindSet() then
            repeat
                TotalAmount += Lot.Subtotal;
                CurrencyCode := lot."Currency Code";
            until Lot.Next() = 0;

        CurrNoteName := 'dollar';
        CurrCoinName := 'cent';

        if Currency.Get(CurrencyCode) then
            CurrNoteName := LowerCase(Currency.Description)
        else
            if Currency.Get(GLSetup."LCY Code") then
                CurrNoteName := LowerCase(Currency.Description);

        InitTextVariables;
        CurBigValueStr := NumberToWords(round(TotalAmount, 1, '<'), CurrNoteName);
        if CurBigValueStr = '' then
            CurBigValueStr := 'zero ' + CurrNoteName;

        CurSmallValueStr := NumberToWords(round(TotalAmount * 100, 1, '<') mod 100, CurrCoinName);
        if CurSmallValueStr = '' then
            CurSmallValueStr := 'zero ' + CurrCoinName;

        exit(StrSubstNo(TotalAmountTextLbl, format(TotalAmount, 0, '<Sign><Integer><Decimals,3>'), CurrencyCode, CurBigValueStr, CurSmallValueStr, CompanyInfo.Name));

    end;

    procedure NumberToWords(number: Integer; appendScale: Text): Text
    var
        numString: Text;
        pow: BigInteger;
        powStr: Text;
        log: Integer;
    begin
        numString := '';

        if number = 0 then
            exit('');

        if number < 100 then
            if number < 20 then
                numString := OnesText[number]
            else begin
                numString := TensText[number DIV 10];
                if (number MOD 10) > 0 then
                    numString := numString + ' ' + OnesText[number MOD 10];
            end
        else begin
            pow := 0;
            powStr := '';
            if number < 1000 then begin
                pow := 100;
                powStr := ThousText[1];
            end else begin
                log := StrLen(format(number)) DIV 3;//number DIV 1000;
                if (StrLen(format(number)) MOD 3 > 0) then
                    log += 1;
                pow := POWER(1000, log - 1);
                powStr := ThousText[log];
            end;

            numString := NumberToWords(number DIV pow, powStr) + ' ' + NumberToWords(number MOD pow, '');
        end;

        exit(DelChr(numString + ' ' + appendScale, '<>'));
    end;

    local procedure InitTextVariables()
    begin
        OnesText[1] := 'one';
        OnesText[2] := 'two';
        OnesText[3] := 'three';
        OnesText[4] := 'four';
        OnesText[5] := 'five';
        OnesText[6] := 'six';
        OnesText[7] := 'seven';
        OnesText[8] := 'eight';
        OnesText[9] := 'nine';
        OnesText[10] := 'ten';
        OnesText[11] := 'eleven';
        OnesText[12] := 'twelve';
        OnesText[13] := 'thirteen';
        OnesText[14] := 'fourteen';
        OnesText[15] := 'fifteen';
        OnesText[16] := 'sixteen';
        OnesText[17] := 'seventeen';
        OnesText[18] := 'eighteen';
        OnesText[19] := 'nineteen';
        OnesText[20] := 'zero';

        TensText[1] := '';
        TensText[2] := 'twenty';
        TensText[3] := 'thirty';
        TensText[4] := 'forty';
        TensText[5] := 'fivty';
        TensText[6] := 'sixty';
        TensText[7] := 'seventy';
        TensText[8] := 'eighty';
        TensText[9] := 'ninty';

        ThousText[1] := 'hundred';
        ThousText[2] := 'thousand';
        ThousText[3] := 'million';
        ThousText[4] := 'billion';
        ThousText[5] := 'trillion';
    end;
}
