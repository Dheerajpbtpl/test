report 50184 "Purchase Order"
{
    //ApplicationArea = All;
    Caption = 'Purchase Order';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\PurchaseOrder.Report.rdl';
    //UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            //DataItemTableView = where("document type" = Filter('order'));

            column(CompName; CompInfo.Name) { }
            column(CompAddress; CompInfo.Address) { }
            column(CompAddress2; CompInfo."Address 2") { }
            column(CompCity; CompInfo.City) { }
            column(CompStatecode; CompInfo."State Code") { }
            column(CompInfoStatecodegst; CompInfoStatecodegst) { }
            column(StateName; StateName) { }
            column(CompInfoCountrycode; CompInfo."Country/Region Code") { }
            column(CountryName; CountryName) { }
            column(CompPincode; CompInfo."Post Code") { }
            column(CompPAN; CompInfo."P.A.N. No.") { }
            column(CompGSTIN; CompInfo."GST Registration No.") { }
            column(CompEmail; ShiptoEmail) { }
            column(CompPicture; CompInfo.Picture) { }
            column(Shiptoname; Shiptoname) { }
            column(ShiptoAdd; ShiptoAdd) { }
            column(ShiptoAdd2; ShiptoAdd2) { }
            column(ShiptoCity; ShiptoCity) { }
            column(ShiptoPostcode; ShiptoPostcode) { }
            column(ShiptoStatecode; ShiptoStatecode) { }
            column(ShiptoStatecodegst; ShiptoStatecodegst) { }
            column(ShiptoEmail; ShiptoEmail) { }
            column(ShiptoCountrycode; ShiptoCountrycode) { }
            column(ShiptoGSTIN; ShiptoGSTIN) { }
            column(ShiptoPAN; ShiptoPAN) { }
            column(ShiptoCountry; ShiptoCountry) { }
            column(ShiptoState; ShiptoState) { }
            column(Ship_to_Name; Purchaseheader."Ship-to Name") { }
            column(Ship_to_Add; Purchaseheader."Ship-to Address") { }
            column(Ship_to_Add2; Purchaseheader."Ship-to Address 2") { }
            column(Ship_to_City; Purchaseheader."Ship-to City") { }
            column(Ship_to_Postcode; Purchaseheader."Ship-to Post Code") { }
            column(Ship_to_Countrycode; Purchaseheader."Ship-to Country/Region Code") { }
            column(Ship_to_Country; Purchaseheader."Ship-to County") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(ShiptoFSSAI; ShiptoFSSAI) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_Address_2; "Buy-from Address 2") { }
            column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(BuyfromPAN; BuyfromPAN) { }
            column(BuyFromState; BuyFromState) { }
            column(Buyfromstatecode; Buyfromstatecode) { }
            column(BuyfromStatecodegst; BuyfromStatecodegst) { }
            column(BuyfromGst; BuyfromGst) { }
            column(BuyfromFSSAI; BuyfromFSSAI) { }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
            column(BuyfromCountry; BuyfromCountry) { }
            column(No_; "No.") { }
            column(Posting_Date; "Order Date") { }
            column(Reference_Invoice_No_; "Vendor Invoice No.") { }
            column(Vendor_Inv__Date; '') { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Narration; Comment_1) { }
            column(Due_Date; "Due Date") { }
            column(CESS; CESS) { }
            column(Amountinwords; Amountinwords[1]) { }
            column(Total; Total) { }
            column(TotalAmount; TotalAmount) { }
            column(Totaltds; Totaltds) { }
            column(CreatedBy; CreatedBy) { }
            column(CreateDate; CreateDate) { }
            column(FirstApprover; FirstApprover) { }
            column(FirstApprovDate; FirstApprovDate) { }
            column(SecondApprover; SecondApprover) { }
            column(SecondApprovDate; SecondApprovDate) { }
            column(ThirdApprover; ThirdApprover) { }
            column(ThirdApprovDate; ThirdApprovDate) { }
            column(comment1; comment1) { }
            column(VarHeading; VarHeading) { }
            column(CompCin; '') { }
            column(CompFSSAI; '') { }

            dataitem(Copyloop;
            Integer)
            {
                DataItemLinkReference = PurchaseHeader;
                DataItemTableView = SORTING(Number);
                dataitem(Pageloop; Integer)
                {
                    // DataItemLinkReference = Copyloop;
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo) { }
                    column(CopyText; CopyText) { }

                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLinkReference = PurchaseHeader;
                        DataItemLink = "Document No." = field("No.");
                        column(VendItemNo; VendItemNo) { }
                        column(Description; Description) { }
                        column(BatchNo; BatchNo) { }
                        column(ExpiryDate; ExpiryDate) { }
                        column(MfgDate; MfgDate) { }
                        column(LotNo; LotNo) { }
                        column(batch; batch) { }
                        column(Bqty; Bqty) { }
                        column(BUOM; BUOM) { }
                        column(exp; exp) { }
                        column(mfg; mfg) { }
                        column(MfgD; MfgD) { }
                        column(ExpiryD; ExpiryD) { }
                        column(Quantity; Quantity) { }
                        column(Rate; "Unit Cost") { }
                        column(Per; UnitMeasure) { }
                        column(Line_Discount__; "Line Discount %") { }
                        column(Line_Amount; "Line Amount") { }
                        column(Department; Department) { }
                        column(SrNo; SrNo) { }
                        column(CGST; CGST) { }
                        column(IGST; IGST) { }
                        column(SGST; SGST) { }
                        column(TDSAmount; TDSAmount) { }
                        column(TDSper; TDSper) { }
                        column(SGST_Per; SGST_Per) { }
                        column(CGST_Per; CGST_Per) { }
                        column(IGST_Per; IGST_Per) { }
                        column(GSTRate; GSTRate) { }
                        column(comment2; comment2) { }
                        column("Indent_No"; '') { }
                        column(HSN_SAC_Code; "HSN/SAC Code") { }


                        trigger OnAfterGetRecord()
                        var
                            myInt: Integer;
                        begin

                            SrNo += 1;

                            // Clear(Department);
                            // IndentHeader.Reset();
                            // IndentHeader.SetRange("Indent No.", PurchaseLine."Indent No.");
                            // if IndentHeader.FindFirst then
                            //     Department := IndentHeader.Department;

                            UOM.Reset();
                            UOM.SetRange(Description, "Purchase Line"."Unit of Measure");
                            if UOM.FindFirst() then
                                UnitMeasure := UOM.Code;


                            Clear(BatchNo);
                            Clear(MfgDate);
                            Clear(ExpiryDate);
                            ResEntry.Reset();
                            ResEntry.SetRange("Source ID", "Purchase Line"."Document No.");
                            ResEntry.SetRange("Item No.", "Purchase Line"."No.");
                            ResEntry.SetRange("Source Ref. No.", "Purchase Line"."Line No.");
                            if ResEntry.FindFirst() then begin
                                repeat
                                    BatchNo := ResEntry."Lot No.";
                                    MfgDate := ResEntry."Warranty Date";
                                    ExpiryDate := ResEntry."Expiration Date";
                                until ResEntry.Next = 0;
                                if BatchB = true then begin
                                    LotNo := BatchNo;
                                    batch := 'Batch No. : ';
                                    exp := Expirydate;
                                    mfg := MfgDate;
                                    MfgD := 'Mfg Date : ';
                                    ExpiryD := 'Expiry Date : ';

                                end;
                            end;

                            if BatchB = true then begin
                                LotNo := BatchNo;
                                batch := 'Batch No. : ';
                                exp := Expirydate;
                                mfg := MfgDate;
                                MfgD := 'Mfg Date : ';
                                ExpiryD := 'Expiry Date : ';

                            end;


                            Clear(IGST);
                            Clear(IGST_Per);
                            Clear(CGST);
                            Clear(CGST_Per);
                            Clear(SGST);
                            Clear(SGST_Per);
                            Clear(ComponentAmt);
                            Clear(TDSAmount);
                            Clear(TDSper);
                            TaxInfomation.Reset();
                            TaxInfomation.SetFilter("Tax Record ID", '%1', "Purchase Line".RecordId);
                            TaxInfomation.SetFilter("Value Type", '%1', TaxInfomation."Value Type"::COMPONENT);
                            TaxInfomation.SetRange("Visible on Interface", true);
                            if TaxInfomation.FindSet() then
                                repeat
                                    ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxInfomation);
                                    if TaxInfomation.GetAttributeColumName = 'CGST' then begin
                                        CGST := ComponentAmt;
                                        CGST_Per := TaxInfomation.Percent;
                                    end;
                                    if TaxInfomation.GetAttributeColumName = 'SGST' then begin
                                        SGST := ComponentAmt;
                                        SGST_Per := TaxInfomation.Percent;
                                    end;
                                    if TaxInfomation.GetAttributeColumName = 'IGST' then begin
                                        IGST := ComponentAmt;
                                        IGST_Per := TaxInfomation.Percent;
                                    end;
                                    if TaxInfomation.GetAttributeColumName = 'TDS' then begin
                                        TDSAmount := ComponentAmt;
                                        TDSper := TaxInfomation.Percent;
                                    end;
                                    GSTRate := CGST_Per + SGST_Per + IGST_Per;
                                until TaxInfomation.Next() = 0;

                            Comment2 := '';
                            PurcCommentLine.RESET;
                            PurcCommentLine.SETRANGE("Document Type", PurcCommentLine."Document Type"::Order);
                            PurcCommentLine.SETRANGE("No.", "Purchase Line"."Document No.");
                            PurcCommentLine.SetRange("Document Line No.", "Purchase Line"."Line No.");
                            IF PurcCommentLine.FINDFIRST THEN
                                repeat
                                    if Comment2 <> '' then
                                        Comment2 := Comment2 + ' , ' + PurcCommentLine.Comment
                                    else
                                        Comment2 := PurcCommentLine.Comment;
                                until PurcCommentLine.Next() = 0;


                            Item.Reset();
                            IF Item.GET("Purchase Line"."No.") THEN begin
                                VendItemNo := Item."Vendor Item No.";
                            end
                        end;


                        trigger OnPreDataItem()
                        var
                            myInt: Integer;
                        begin
                            SrNo := 0;
                        end;
                    }

                }



                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    // CurrReport.PAGENO := 1;
                    IF Number = 1 THEN
                        CopyText := 'ORIGINAL FOR RECIPIENT';
                    IF Number = 2 THEN
                        CopyText := 'DUPLICATE-FOR TRANSPORTER';
                    IF Number = 3 THEN
                        CopyText := 'TRIPLICATE-FOR SUPPLIER';
                    IF Number > 3 THEN
                        CopyText := 'EXTRA COPY';
                    OutputNo += 1;
                    IF Number > 1 THEN BEGIN
                        OutputNo += 1;
                    END;
                end;


                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin

                    NoofLoops := ABS(NoofCopies);
                    IF NoofLoops <= 0 THEN
                        NoofLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoofLoops);
                    OutputNo := 0;

                end;
            }


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Clear(StateName);
                StateRec.Reset;
                StateRec.SetRange(Code, CompInfo."State Code");
                if StateRec.FindFirst() then begin
                    StateName := StateRec.Description;
                    CompInfoStatecodegst := StateRec."State Code (GST Reg. No.)";
                end;

                Clear(CountryName);
                CountryRec.Reset;
                CountryRec.SetRange(Code, CompInfo."Country/Region Code");
                if CountryRec.FindFirst then
                    CountryName := CountryRec.Name;

                Clear(BuyfromCountry);
                CountryRec.Reset;
                CountryRec.SetRange(Code, "Buy-from Country/Region Code");
                if CountryRec.FindFirst then
                    BuyfromCountry := CountryRec.Name;


                Clear(BuyfromPAN);
                Clear(BuyFromState);
                Clear(Buyfromstatecode);
                Clear(BuyfromGst);
                Clear(BuyfromStatecodegst);
                VenRec.Reset();
                VenRec.SetRange("No.", PurchaseHeader."Buy-from Vendor No.");
                if VenRec.FindFirst() then begin
                    BuyfromPAN := VenRec."P.A.N. No.";
                    Buyfromstatecode := VenRec."State Code";
                    BuyfromGst := VenRec."GST Registration No.";

                    StateRec.Reset;
                    StateRec.SetRange(Code, Buyfromstatecode);
                    if StateRec.FindFirst then begin
                        BuyFromState := StateRec.Description;
                        BuyfromStatecodegst := StateRec."State Code (GST Reg. No.)";
                    end;


                end;


                Shiptoname := '';
                ShiptoAdd := '';
                ShiptoAdd2 := '';
                Clear(ShiptoCity);
                Clear(ShiptoPostcode);
                Clear(ShiptoStatecode);
                Clear(ShiptoCountrycode);
                Clear(ShiptoEmail);
                Clear(ShiptoGSTIN);
                Clear(ShiptoPAN);
                Clear(ShiptoFSSAI);
                Location.Reset();
                Location.SetRange(code, PurchaseHeader."Location Code");
                if Location.FindFirst() then begin
                    Shiptoname := Location.Name;
                    ShiptoAdd := Location.Address;
                    ShiptoAdd2 := Location."Address 2";
                    ShiptoCity := Location.City;
                    ShiptoPostcode := Location."Post Code";
                    ShiptoStatecode := Location."State Code";
                    ShiptoCountrycode := Location."Country/Region Code";
                    ShiptoEmail := Location."E-Mail";
                    ShiptoGSTIN := Location."GST Registration No.";

                    Clear(ShiptoState);
                    Clear(ShiptoStatecodegst);
                    StateRec.Reset;
                    StateRec.SetRange(Code, ShiptoStatecode);
                    if StateRec.FindFirst then begin
                        ShiptoState := StateRec.Description;
                        ShiptoStatecodegst := StateRec."State Code (GST Reg. No.)";
                    end;

                    Clear(ShiptoCountry);
                    CountryRec.Reset;
                    CountryRec.SetRange(Code, ShiptoCountrycode);
                    if CountryRec.FindFirst then
                        ShiptoCountry := CountryRec.Name;
                end;

                Clear(Total);
                Clear(TotalAmount);
                Clear(Totalgst);
                Clear(Totaltds);
                PurchaseLine.Reset;
                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                if PurchaseLine.FindFirst then
                    repeat
                        Total += PurchaseLine."Line Amount";

                        TaxInfomation.Reset();
                        TaxInfomation.SetFilter("Tax Record ID", '%1', PurchaseLine.RecordId);
                        TaxInfomation.SetFilter("Value Type", '%1', TaxInfomation."Value Type"::COMPONENT);
                        TaxInfomation.SetRange("Visible on Interface", true);
                        if TaxInfomation.FindFirst() then
                            repeat
                                ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxInfomation);
                                if TaxInfomation.GetAttributeColumName = 'CGST' then begin
                                    Totalgst += ComponentAmt;
                                end;
                                if TaxInfomation.GetAttributeColumName = 'SGST' then begin
                                    Totalgst += ComponentAmt;
                                end;
                                if TaxInfomation.GetAttributeColumName = 'IGST' then begin
                                    Totalgst += ComponentAmt;
                                end;
                                if TaxInfomation.GetAttributeColumName = 'TDS' then begin
                                    Totaltds += ComponentAmt;
                                end;
                            until TaxInfomation.Next() = 0;

                    until PurchaseLine.Next = 0;

                TotalAmount := Total + Totalgst - Totaltds;

                Clear(Amountinwords);
                TotalAmount := Round(TotalAmount, 0.01);
                InitTextVariable();
                FormatNoText(NoText, TotalAmount, '');
                Amountinwords[1] := NoText[1];

                Comment1 := '';
                PurcCommentLine.RESET;
                PurcCommentLine.SETRANGE("Document Type", PurcCommentLine."Document Type"::Order);
                PurcCommentLine.SETRANGE("No.", "No.");
                PurcCommentLine.SetRange("Document Line No.", 0);
                IF PurcCommentLine.FINDFIRST THEN
                    repeat
                        if Comment1 <> '' then
                            Comment1 := Comment1 + ' , ' + PurcCommentLine.Comment
                        else
                            Comment1 := PurcCommentLine.Comment;
                    until PurcCommentLine.Next() = 0;




                ApprovalEntryRec.Reset();
                UserRec.Reset();
                Clear(CreatedBy);
                Clear(FirstApprover);
                Clear(CreateDate);
                Clear(FirstApprovDate);
                ApprovalEntryRec.SetRange("Document No.", PurchaseHeader."No.");
                if ApprovalEntryRec.FindFirst() then
                    ApprovalEntryRec.SetRange("Sequence No.", 1);
                if ApprovalEntryRec.FindLast() then begin
                    CreateDate := ApprovalEntryRec."Date-Time Sent for Approval";

                    UserRec.SetRange("User Name", ApprovalEntryRec."Sender ID");
                    if UserRec.FindFirst() then
                        CreatedBy := UserRec."Full Name";
                    ApprovalEntryRec.SetFilter("Last Date-Time Modified", '>%1', ApprovalEntryRec."Date-Time Sent for Approval");
                    if ApprovalEntryRec.FindFirst() then begin
                        FirstApprovDate := ApprovalEntryRec."Last Date-Time Modified";
                        UserRec.SetRange("User Name", ApprovalEntryRec."Approver ID");
                        if UserRec.FindFirst() then
                            FirstApprover := UserRec."Full Name";
                    end;
                end;

                ApprovalEntryRec.Reset();
                UserRec.Reset();
                Clear(SecondApprover);
                Clear(SecondApprovDate);
                ApprovalEntryRec.SetRange("Document No.", PurchaseHeader."No.");
                if ApprovalEntryRec.FindFirst() then
                    ApprovalEntryRec.SetRange("Sequence No.", 2);
                if ApprovalEntryRec.Findlast() then begin
                    ApprovalEntryRec.SetFilter("Last Date-Time Modified", '>%1', ApprovalEntryRec."Date-Time Sent for Approval");
                    if ApprovalEntryRec.FindFirst() then begin
                        SecondApprovDate := ApprovalEntryRec."Last Date-Time Modified";
                        UserRec.SetRange("User Name", ApprovalEntryRec."Approver ID");
                        if UserRec.FindFirst() then
                            SecondApprover := UserRec."Full Name";
                    end;
                end;

                ApprovalEntryRec.Reset();
                UserRec.Reset();
                Clear(ThirdApprover);
                Clear(ThirdApprovDate);
                ApprovalEntryRec.SetRange("Document No.", PurchaseHeader."No.");
                if ApprovalEntryRec.FindFirst() then
                    ApprovalEntryRec.SetRange("Sequence No.", 3);
                if ApprovalEntryRec.Findlast() then begin
                    ApprovalEntryRec.SetFilter("Last Date-Time Modified", '>%1', ApprovalEntryRec."Date-Time Sent for Approval");
                    if ApprovalEntryRec.FindFirst() then begin
                        ThirdApprovDate := ApprovalEntryRec."Last Date-Time Modified";
                        UserRec.SetRange("User Name", ApprovalEntryRec."Approver ID");
                        if UserRec.FindFirst() then
                            ThirdApprover := UserRec."Full Name";
                    end;
                end;

                if Status = Status::Released then
                    VarHeading := 'Purchase order'
                else
                    VarHeading := 'Draft order, Not for Supply';
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(NoofCopies; NoofCopies)
                {
                    ApplicationArea = all;
                }
                field("Batch No"; BatchB)
                {
                    ApplicationArea = all;
                }

                /* field("PO. No"; No)
                {
                    ApplicationArea = All;
                    TableRelation = "Purchase Header"."No.";
                } */
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
        NoOfCopies := 1;
        BatchB := true;
    end;

    var
        Item: Record Item;
        VendItemNo: Code[40];
        VarHeading: text[50];

        CompInfo: Record 79;
        CompInfoStatecodegst: Code[10];
        No: Code[20];
        StateRec: Record State;
        StateName: Text;
        CountryRec: Record "Country/Region";
        VenRec: Record 23;
        BuyfromPAN: code[20];
        BuyFromState: Text;
        Buyfromstatecode: Code[10];
        BuyfromStatecodegst: Code[10];
        BuyfromGst: Code[20];
        CountryName: Text;
        Shiptoname: Text;
        ShiptoAdd: Text;
        ShiptoAdd2: Text;
        ShiptoCity: Text;
        ShiptoEmail: Text;
        ShiptoStatecode: Code[10];
        ShiptoStatecodegst: Code[10];
        ShiptoPostcode: Code[10];
        ShiptoGSTIN: Text;
        ShiptoPAN: Text;
        ShiptoFSSAI: Code[20];
        ShiptoCountry: Text;
        ShiptoCountrycode: Code[10];
        ShiptoState: Text;
        PurcCommentLine: Record "Purch. Comment Line";
        comment1: text;
        comment2: text;
        Comment_1: text;
        BuyfromCountry: Text;
        BuyfromFSSAI: Code[20];
        DGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        ILE: Record "Item Ledger Entry";
        ResEntry: Record 337;
        BatchNo: Code[50];
        ExpiryDate: Date;
        MfgDate: Date;
        BatchB: Boolean;
        LotNo: Code[30];
        batch: Text;
        Bqty: Decimal;
        BUOM: Code[30];
        mfg: Date;
        exp: Date;
        ExpiryD: Text;
        MfgD: Text;
        UOM: Record 204;
        UnitMeasure: Code[10];
        TaxInfomation: Record "Tax Transaction Value";
        TaxTypeObjHelper: Codeunit 20232;
        ComponentAmt: Decimal;
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        CESS: Decimal;
        GSTRate: Decimal;
        CGST_Per: Decimal;
        SGST_Per: Decimal;
        IGST_Per: Decimal;
        Totalgst: Decimal;
        Frieght: Decimal;
        SrNo: Integer;
        Total: Decimal;
        TotalAmount: Decimal;
        Amountinwords: array[2] of Text[100];
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderRec: Record "Purchase Header";
        PurchHeaderRec: Record "Purchase Header";
        TDSAmount: Decimal;
        Totaltds: Decimal;
        TDSper: Decimal;
        NoText: array[2] of Text[100];

        Location: Record Location;
        //  PostedNarration: Record "Posted Narration";
        OutputNo: Integer;
        CopyText: Text;
        NoofLoops: Integer;
        NoofCopies: Integer;
        // IndentHeader: Record "Indent Header";
        ApprovalEntryRec: Record "Approval Entry";
        CreatedBy: Text;
        CreateDate: DateTime;
        FirstApprover: Text;
        FirstApprovDate: DateTime;
        SecondApprover: Text;
        SecondApprovDate: DateTime;
        ThirdApprover: Text;
        ThirdApprovDate: DateTime;
        UserRec: Record User;
        VarHeading1: Code[20];


        Department: text[100];
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKH';
        Text16563: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];

    procedure FormatNoText(var NoText: array[2] of Text[100]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record 4;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[100]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text16529, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;

        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;

        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;

    end;

}
