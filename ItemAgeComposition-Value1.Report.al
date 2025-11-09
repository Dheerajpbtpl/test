/// <summary>
/// Report Item Age Composition - Value1 (ID 50047).
/// </summary>
/// Taneesh
Report 50047 "Item Age Composition - Value1"
{
    Caption = 'Item Age Composition - Value';
    RDLCLayout = './Layouts/ItemAgeComposition-Value1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            // RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter", "Product Group Code", "Global Dimension 2 Filter", "Date Filter", Inventory;
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }

            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TableCaption + ': ' + ItemFilter)
            {
            }
            column(PeriodStartDate_2____1; PeriodStartDate[2] + 1)
            {
            }
            column(PeriodStartDate_3___; PeriodStartDate[3])
            {
            }
            column(PeriodStartDate_3____1; PeriodStartDate[3] + 1)
            {
            }
            column(PeriodStartDate_4_; PeriodStartDate[4])
            {
            }
            column(PeriodStartDate_4_____1; PeriodStartDate[4] + 1)
            {
            }
            column(PeriodStartDate_5___; PeriodStartDate[5])
            {
            }
            column(PeriodStartDate_5__PeriodStartDate_4___; PeriodStartDate[5])
            {
            }
            column(PeriodStartDate_5__PeriodStartDate_3___; PeriodStartDate[5])
            {
            }
            column(PeriodStartDate_5__PeriodStartDate_2__; PeriodStartDate[5])
            {
            }
            column(PeriodStartDate_2____1_Control1000000045; PeriodStartDate[2] + 1)
            {
            }
            column(PeriodStartDate_5____Control1000000046; PeriodStartDate[5])
            {
            }
            column(InvtValue_1_; InvtValue[1])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_1_; InvtQty[1])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_2_; InvtValue[2])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_2_; InvtQty[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_3_; InvtValue[3])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_3_; InvtQty[3])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_4_; InvtValue[4])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_4_; InvtQty[4])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_5_; InvtValue[5])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_5_; InvtQty[5])
            {
                AutoFormatType = 1;
            }
            column(TotalInvtValue; TotalInvtValue)
            {
                AutoFormatType = 1;
            }
            column(NetTotalInvQty; NetTotalInvQty)
            {
                AutoFormatType = 1;
            }
            column(productname1; productname1)
            {
            }
            column(InvtValue_1__Control1000000021; InvtValue[1])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_1__Control1000000022; InvtQty[1])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_2__Control1000000020; InvtValue[2])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_2__Control1000000023; InvtQty[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_3__Control1000000019; InvtValue[3])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_3__Control1000000024; InvtQty[3])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_4__Control1000000018; InvtValue[4])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_4__Control1000000025; InvtQty[4])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_5__Control1000000017; InvtValue[5])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_5__Control1000000026; InvtQty[5])
            {
                AutoFormatType = 1;
            }
            column(TotalInvtValue_Control1000000016; TotalInvtValue)
            {
                AutoFormatType = 1;
            }
            column(NetTotalInvQty_Control1000000040; NetTotalInvQty)
            {
                AutoFormatType = 1;
            }
            column(InvtValue_2__Control1000000031; InvtValue[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_1__Control1000000032; InvtValue[1])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_1__Control1000000033; InvtQty[1])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_2__Control1000000034; InvtQty[2])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_3__Control1000000030; InvtValue[3])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_3__Control1000000035; InvtQty[3])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_4__Control1000000029; InvtValue[4])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_4__Control1000000036; InvtQty[4])
            {
                AutoFormatType = 1;
            }
            column(InvtValue_5__Control1000000028; InvtValue[5])
            {
                AutoFormatType = 1;
            }
            column(InvtQty_5__Control1000000037; InvtQty[5])
            {
                AutoFormatType = 1;
            }
            column(TotalInvtValue_Control1000000027; TotalInvtValue)
            {
                AutoFormatType = 1;
            }
            column(NetTotalInvQty_Control1000000041; NetTotalInvQty)
            {
                AutoFormatType = 1;
            }
            column(Item_Age_Composition___ValueCaption; Item_Age_Composition___ValueCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(InvtValue_5__Control28Caption; InvtValue_5__Control28CaptionLbl)
            {
            }
            column(InvtValue_1__Control32Caption; InvtValue_1__Control32CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Item__Vendor_Item_No__Caption; Item__Vendor_Item_No__CaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(ValueCaption_Control1000000049; ValueCaption_Control1000000049Lbl)
            {
            }
            column(QtyCaption_Control1000000050; QtyCaption_Control1000000050Lbl)
            {
            }
            column(QtyCaption_Control1000000051; QtyCaption_Control1000000051Lbl)
            {
            }
            column(ValueCaption_Control1000000052; ValueCaption_Control1000000052Lbl)
            {
            }
            column(ValueCaption_Control1000000053; ValueCaption_Control1000000053Lbl)
            {
            }
            column(QtyCaption_Control1000000054; QtyCaption_Control1000000054Lbl)
            {
            }
            column(QtyCaption_Control1000000055; QtyCaption_Control1000000055Lbl)
            {
            }
            column(ValueCaption_Control1000000056; ValueCaption_Control1000000056Lbl)
            {
            }
            column(ValueCaption_Control1000000057; ValueCaption_Control1000000057Lbl)
            {
            }
            column(QtyCaption_Control1000000058; QtyCaption_Control1000000058Lbl)
            {
            }
            column(Product_Group_NameCaption; Product_Group_NameCaptionLbl)
            {
            }
            column(Brought_ForwardCaption; Brought_ForwardCaptionLbl)
            {
            }
            column(Carried_ForwardCaption; Carried_ForwardCaptionLbl)
            {
            }
            column(TotalCaption_Control21; TotalCaption_Control21Lbl)
            {
            }
            column(Item_No_; Item."No.")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No."), "Location Code" = field("Location Filter"), "Variant Code" = field("Variant Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
                DataItemTableView = sorting("Item No.", Open) where(Open = const(true));
                column(ReportForNavId_7209; 7209) { } // Autogenerated by ForNav - Do not delete
                column(InvtValue_1_2; InvtValue[1])
                {
                }
                column(InvtQty_1_2; InvtQty[1])
                {
                }
                column(InvtValue_2_2; InvtValue[2])
                {
                }
                column(InvtQty_2_2; InvtQty[2])
                {
                }
                column(InvtValue_3_2; InvtValue[3])
                {
                }
                column(InvtQty_3_2; InvtQty[3])
                {
                }
                column(InvtValue_4_2; InvtValue[4])
                {
                }
                column(InvtQty_4_2; InvtQty[4])
                {
                }
                column(InvtValue_5_2; InvtValue[5])
                {
                }
                column(InvtQty_5_2; InvtQty[5])
                {
                }
                column(TotalInvtValue2; TotalInvtValue)
                {
                }
                column(NetTotalInvQty2; NetTotalInvQty)
                {
                }
                trigger OnPreDataItem();
                begin

                end;

                trigger OnAfterGetRecord();
                begin
                    if "Remaining Quantity" = 0 then
                        CurrReport.Skip;
                    PrintLine := true;
                    if Item.GetFilter(Item."Location Filter") <> '' then
                        SourceDate := "Posting Date"
                    else
                        CalcSourceDate;
                    CalcRemainingQty;
                    if Item."Costing Method" = Item."costing method"::Average then begin
                        TotalInvtValue := AverageCost * TotalInvtQty;
                        InvtValue[i] := AverageCost * InvtQty[i];
                    end else begin
                        CalcUnitCost;
                        TotalInvtValue := UnitCost * TotalInvtQty;
                        InvtValue[i] := UnitCost * InvtQty[i];
                    end;
                end;

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444) { } // Autogenerated by ForNav - Do not delete
                column(TotalInvtValue_Control23; TotalInvtValue)
                {
                    AutoFormatType = 1;
                }
                column(InvtValue_5__Control28; InvtValue[5])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue_4__Control49; InvtValue[4])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue_3__Control48; InvtValue[3])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue_2__Control47; InvtValue[2])
                {
                    AutoFormatType = 1;
                }
                column(InvtValue_1__Control32; InvtValue[1])
                {
                    AutoFormatType = 1;
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item__Vendor_Item_No__; Item."Vendor Item No.")
                {
                }
                column(InvtQty_1__Control1000000000; InvtQty[1])
                {
                    AutoFormatType = 1;
                }
                column(InvtQty_2__Control1000000001; InvtQty[2])
                {
                    AutoFormatType = 1;
                }
                column(InvtQty_3__Control1000000002; InvtQty[3])
                {
                    AutoFormatType = 1;
                }
                column(InvtQty_4__Control1000000003; InvtQty[4])
                {
                    AutoFormatType = 1;
                }
                column(InvtQty_5__Control1000000004; InvtQty[5])
                {
                    AutoFormatType = 1;
                }
                column(LocTotalInvQty; LocTotalInvQty)
                {
                    AutoFormatType = 1;
                }
                column(productname1_Control1000000067; productname1)
                {
                }
                column(Integer_Number; Integer.Number)
                {
                }
            }
            trigger OnPreDataItem();
            begin

            end;

            trigger OnAfterGetRecord();
            begin
                if Item."Costing Method" = Item."costing method"::Average then
                    ItemCostMgt.CalculateAverageCost(Item, AverageCost, AverageCostACY);
                PrintLine := false;
                TotalInvtQty := 0;
                LocTotalInvQty := 0;
                //  productgroup.SetRange(productgroup.Code, Item."Product Group Code");
                //  if productgroup.FindFirst then
                //    Productname := productgroup.Description;
                // win43 for Product Name
                /*
				Dimvalue.SETRANGE(Dimvalue.Code,Item."Global Dimension 1 Code");
				IF Dimvalue.FINDFIRST THEN
				  Productname:=Dimvalue.Name;
				*/
                // end

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(EndingDate; PeriodStartDate[5])
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ending Date';

                        trigger OnValidate()
                        begin
                            if PeriodStartDate[5] = 0D then
                                Error(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Length';

                        trigger OnValidate()
                        begin
                            if Format(PeriodLength) = '' then
                                Evaluate(PeriodLength, '<0D>');
                        end;
                    }

                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if PeriodStartDate[5] = 0D then
                PeriodStartDate[5] := CalcDate('<CM>', WorkDate);
            if Format(PeriodLength) = '' then
                Evaluate(PeriodLength, '<1M>');
        end;
    }



    trigger OnPreReport()
    begin
        ItemFilter := Item.GetFilters;
        PeriodStartDate[6] := 99991231D;
        for i := 1 to 3 do
            // PeriodStartDate[5 - i] := CALCDATE('-' + FORMAT(PeriodLength),PeriodStartDate[6 - i]);
            PeriodStartDate[5 - i] := CalcDate('<-' + Format(PeriodLength) + '>', PeriodStartDate[6 - i]);
        if UseCustomLength then  //Winspire with All Defined Periods
          begin
            PeriodEndDate[5] := EndingDate;
            PeriodStartDate[5] := EndingDate - PerLength1;
            PeriodEndDate[4] := PeriodStartDate[5] - 1;
            PeriodStartDate[4] := PeriodEndDate[4] - PerLength2;
            PeriodEndDate[3] := PeriodStartDate[4] - 1;
            PeriodStartDate[3] := PeriodEndDate[3] - PerLength3;
            PeriodEndDate[2] := PeriodStartDate[3] - 1;
            PeriodStartDate[2] := PeriodEndDate[2] - PerLength4;
            PeriodEndDate[1] := PeriodStartDate[2] - 1;
            PeriodStartDate[1] := 0D;
        end;

    end;

    var
        Text002: label 'Enter the ending date';
        ItemCostMgt: Codeunit ItemCostManagement;
        ItemFilter: Text[250];
        InvtValue: array[6] of Decimal;
        ExpectedInvtValue: array[6] of Decimal;
        InvtQty: array[6] of Decimal;
        TotalInvoicedQty: Decimal;
        UnitCost: Decimal;
        ExpectedUnitCost: Decimal;
        PeriodStartDate: array[6] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtValue: Decimal;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        NetTotalInvQty: Decimal;
        PerLength: Integer;
        LocTotalInvQty: Decimal;
        PerLength1: Integer;
        PerLength2: Integer;
        PerLength3: Integer;
        PerLength4: Integer;
        UseCustomLength: Boolean;
        Start1: Integer;
        End1: Integer;
        Start2: Integer;
        End2: Integer;
        Start3: Integer;
        End3: Integer;
        Start4: Integer;
        End4: Integer;
        PeriodEndDate: array[6] of Date;
        EndingDate: Date;
        j: Text[30];
        printoexcel: Boolean;
        cnt: Integer;
        Cnt1: Integer;
        ILE: Record "Item Ledger Entry";
        ItemAplnEntry: Record "Item Application Entry";
        SourceDate: Date;
        SourceFound: Boolean;
        InboundEntryNo: Integer;
        Dimvalue: Record "Dimension Value";
        Productname: Text[250];
        productname1: Text[30];
        // productgroup: Record "Product Group";
        Item_Age_Composition___ValueCaptionLbl: label 'Item Age Composition - Value';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        InvtValue_5__Control28CaptionLbl: label 'after...';
        InvtValue_1__Control32CaptionLbl: label '...before';
        TotalCaptionLbl: label 'Total';
        Item_DescriptionCaptionLbl: label 'Description';
        Item__Vendor_Item_No__CaptionLbl: label 'Item No.';
        ValueCaptionLbl: label 'Value';
        QtyCaptionLbl: label 'Qty';
        ValueCaption_Control1000000049Lbl: label 'Value';
        QtyCaption_Control1000000050Lbl: label 'Qty';
        QtyCaption_Control1000000051Lbl: label 'Qty';
        ValueCaption_Control1000000052Lbl: label 'Value';
        ValueCaption_Control1000000053Lbl: label 'Value';
        QtyCaption_Control1000000054Lbl: label 'Qty';
        QtyCaption_Control1000000055Lbl: label 'Qty';
        ValueCaption_Control1000000056Lbl: label 'Value';
        ValueCaption_Control1000000057Lbl: label 'Value';
        QtyCaption_Control1000000058Lbl: label 'Qty';
        Product_Group_NameCaptionLbl: label 'Product Group Name';
        Brought_ForwardCaptionLbl: label 'Brought Forward';
        Carried_ForwardCaptionLbl: label 'Carried Forward';
        TotalCaption_Control21Lbl: label 'Total';

    procedure CalcRemainingQty()
    begin
        for i := 1 to 5 do begin
            InvtQty[i] := 0;
            InvtValue[i] := 0;
        end;
        TotalInvtQty := "Item Ledger Entry"."Remaining Quantity";
        LocTotalInvQty += TotalInvtQty;
        NetTotalInvQty += TotalInvtQty;
        for i := 1 to 5 do
            if (SourceDate > PeriodStartDate[i]) and
               (SourceDate <= PeriodStartDate[i + 1])
            then
                if "Item Ledger Entry"."Remaining Quantity" <> 0 then begin
                    InvtQty[i] := "Item Ledger Entry"."Remaining Quantity";
                    exit;
                end;
    end;

    procedure CalcUnitCost()
    begin
        "Item Ledger Entry".CalcFields("Cost Amount (Expected)", "Cost Amount (Actual)");
        UnitCost := ("Item Ledger Entry"."Cost Amount (Actual)" + "Item Ledger Entry"."Cost Amount (Expected)") / "Item Ledger Entry".Quantity;
    end;

    procedure CalcSourceDate()
    begin
        InboundEntryNo := "Item Ledger Entry"."Entry No.";
        SourceFound := false;
        cnt := 1;
        repeat
            ItemAplnEntry.SetRange(ItemAplnEntry."Inbound Item Entry No.", InboundEntryNo);
            if ItemAplnEntry.FindFirst then begin
                if ItemAplnEntry."Transferred-from Entry No." <> 0 then
                    InboundEntryNo := ItemAplnEntry."Transferred-from Entry No."
                else
                    SourceFound := true;
            end else begin
                SourceFound := true;
            end;
            cnt += 1;
        until (cnt = 10) or SourceFound;
        if SourceFound then begin
            ILE.Get(InboundEntryNo);
            //Age := TODAY - ILE."Posting Date";
            SourceDate := ILE."Posting Date";
        end else begin
            //Age := TODAY - "Item Ledger Entry"."Posting Date";
            SourceDate := "Item Ledger Entry"."Posting Date";
        end;
    end;


}
