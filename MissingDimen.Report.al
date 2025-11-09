/// <summary>
/// Report Missing Dimen (ID 50070).
/// </summary>
Report 50070 "Missing Dimen"
{
    Permissions = TableData "G/L Entry" = rimd,
                  TableData "Item Ledger Entry" = rimd,
                  TableData "Sales Shipment Header" = rimd,
                  TableData "Sales Shipment Line" = rimd,
                  TableData "Sales Invoice Header" = rimd,
                  TableData "Sales Invoice Line" = rimd,
                  TableData "Sales Cr.Memo Header" = rimd,
                  TableData "Sales Cr.Memo Line" = rimd,
                  TableData "Purch. Rcpt. Header" = rimd,
                  TableData "Purch. Rcpt. Line" = rimd,
                  TableData "Purch. Inv. Header" = rimd,
                  TableData "Purch. Inv. Line" = rimd,
                  TableData "Purch. Cr. Memo Hdr." = rimd,
                  TableData "Purch. Cr. Memo Line" = rimd,
                  TableData "Transfer Shipment Header" = rimd,
                  TableData "Transfer Shipment Line" = rimd,
                  TableData "Transfer Receipt Header" = rimd,
                  TableData "Transfer Receipt Line" = rimd,
                  TableData "Value Entry" = rimd;
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            RequestFilterFields = "Entry No.";

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Entry No." = field("Item Ledger Entry No."), "Posting Date" = field("Posting Date");
                DataItemTableView = sorting("Entry No.");

                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = field("Document No."), "No." = field("Item No."), "Posting Date" = field("Posting Date");
                    DataItemTableView = sorting("Document No.", "Line No.");


                    trigger OnAfterGetRecord()
                    begin

                        if "Shortcut Dimension 2 Code" <> BusDim then begin
                            "Shortcut Dimension 2 Code" := BusDim;
                            Modify;
                            //GetPostedDocDim("Document No.","Line No.",111,'BUS',BusDim);
                        end;
                        if "Shortcut Dimension 1 Code" <> BrDim then begin
                            "Shortcut Dimension 1 Code" := BrDim;
                            Modify;
                            //  GetPostedDocDim("Document No.","Line No.",111,'BR',BrDim);
                        end;

                        /*IF SalesDim <> '' THEN
                          GetPostedDocDim("Document No.","Line No.",111,'SMAN',SalesDim);
                         */

                    end;
                }
                dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                {
                    DataItemLink = "Document No." = field("Document No."), "No." = field("Item No.");
                    DataItemTableView = sorting("Document No.", "Line No.");


                    trigger OnAfterGetRecord()
                    begin

                        if "Shortcut Dimension 2 Code" <> BusDim then begin
                            "Shortcut Dimension 2 Code" := BusDim;
                            Modify;
                            // GetPostedDocDim("Document No.","Line No.",121,'BUS',BusDim);
                        end;
                        if "Shortcut Dimension 1 Code" <> BrDim then begin
                            "Shortcut Dimension 1 Code" := BrDim;
                            Modify;
                            //  GetPostedDocDim("Document No.","Line No.",121,'BR',BrDim);
                        end;

                        /*IF SalesDim <> '' THEN
                          GetPostedDocDim("Document No.","Line No.",121,'SMAN',SalesDim);
                         */

                    end;
                }
                dataitem("Sales Shipment Header"; "Sales Shipment Header")
                {
                    DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");

                    trigger OnAfterGetRecord()
                    begin

                        if "Shortcut Dimension 1 Code" <> BrDim then begin
                            "Shortcut Dimension 1 Code" := BrDim;
                            Modify;
                            // GetPostedDocDim("No.",0,110,'BR',BrDim);
                        end;
                    end;
                }
                dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
                {
                    DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");


                    trigger OnAfterGetRecord()
                    begin

                        if "Shortcut Dimension 1 Code" <> BrDim then begin
                            "Shortcut Dimension 1 Code" := BrDim;
                            Modify;
                            //  GetPostedDocDim("No.",0,120,'BR',BrDim);
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    if "Global Dimension 2 Code" <> BusDim then begin
                        "Global Dimension 2 Code" := BusDim;
                        Modify;
                    end;

                    //GetLedgEntryDim("Entry No.",32,'BUS',BusDim);

                    if "Global Dimension 1 Code" <> BrDim then begin
                        "Global Dimension 1 Code" := BrDim;
                        Modify;
                    end;

                    //GetLedgEntryDim("Entry No.",32,'BR',BrDim);

                    //IF SalesDim <> '' THEN
                    // GetLedgEntryDim("Entry No.",32,'SMAN',SalesDim);
                end;
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Entry No." = field("Entry No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin

                    if "Global Dimension 2 Code" <> BusDim then begin
                        "Global Dimension 2 Code" := BusDim;
                        Modify;
                        //  GetLedgEntryDim("Entry No.",17,'BUS',BusDim);
                    end;
                    if "Global Dimension 1 Code" <> BrDim then begin
                        "Global Dimension 1 Code" := BrDim;
                        Modify;
                        // GetLedgEntryDim("Entry No.",17,'BR',BrDim);
                    end;
                    /*
                    IF SalesDim <> '' THEN
                      GetLedgEntryDim("Entry No.",17,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("Document No."), "No." = field("Item No."), "Posting Date" = field("Posting Date");

                trigger OnAfterGetRecord()
                begin

                    if "Shortcut Dimension 2 Code" <> BusDim then begin
                        "Shortcut Dimension 2 Code" := BusDim;
                        Modify;
                        //GetPostedDocDim("Document No.","Line No.",113,'BUS',BusDim);
                    end;
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetPostedDocDim("Document No.","Line No.",113,'BR',BrDim);
                    end;
                    /*
                    IF SalesDim <> '' THEN
                      GetPostedDocDim("Document No.","Line No.",113,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("Document No."), "No." = field("Item No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin
                    if "Shortcut Dimension 2 Code" <> BusDim then begin
                        "Shortcut Dimension 2 Code" := BusDim;
                        Modify;
                        //GetPostedDocDim("Document No.","Line No.",113,'BUS',BusDim);
                    end;
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetPostedDocDim("Document No.","Line No.",113,'BR',BrDim);
                    end;
                    /*
                    IF SalesDim <> '' THEN
                      GetPostedDocDim("Document No.","Line No.",113,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("Document No."), "No." = field("Item No."), "Posting Date" = field("Posting Date");

                trigger OnAfterGetRecord()
                begin
                    if "Shortcut Dimension 2 Code" <> BusDim then begin
                        "Shortcut Dimension 2 Code" := BusDim;
                        Modify;
                        //GetPostedDocDim("Document No.","Line No.",113,'BUS',BusDim);
                    end;
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetPostedDocDim("Document No.","Line No.",113,'BR',BrDim);
                    end;
                    /*
                    IF SalesDim <> '' THEN
                      GetPostedDocDim("Document No.","Line No.",113,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("Document No."), "No." = field("Item No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin
                    if "Shortcut Dimension 2 Code" <> BusDim then begin
                        "Shortcut Dimension 2 Code" := BusDim;
                        Modify;
                        //GetPostedDocDim("Document No.","Line No.",113,'BUS',BusDim);
                    end;
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetPostedDocDim("Document No.","Line No.",113,'BR',BrDim);
                    end;
                    /*
                    IF SalesDim <> '' THEN
                      GetPostedDocDim("Document No.","Line No.",113,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field("Document No."), "Item No." = field("Item No."), "Shipment Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin

                    if "Shortcut Dimension 2 Code" <> BusDim then begin
                        "Shortcut Dimension 2 Code" := BusDim;
                        Modify;
                        //GetPostedDocDim("Document No.","Line No.",5745,'BUS',BusDim);
                    end;
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetPostedDocDim("Document No.","Line No.",5745,'BR',BrDim);
                    end;

                    /*IF SalesDim <> '' THEN
                      GetPostedDocDim("Document No.","Line No.",5745,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = field("Document No."), "Item No." = field("Item No."), "Receipt Date" = field("Posting Date");

                trigger OnAfterGetRecord()
                begin

                    if "Shortcut Dimension 2 Code" <> BusDim then begin
                        "Shortcut Dimension 2 Code" := BusDim;
                        Modify;
                        //GetPostedDocDim("Document No.","Line No.",5745,'BUS',BusDim);
                    end;
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetPostedDocDim("Document No.","Line No.",5745,'BR',BrDim);
                    end;

                    /*IF SalesDim <> '' THEN
                      GetPostedDocDim("Document No.","Line No.",5745,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin

                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //    GetPostedDocDim("No.",0,112,'BR',BrDim);
                    end;
                end;
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //    GetPostedDocDim("No.",0,112,'BR',BrDim);
                    end;
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //    GetPostedDocDim("No.",0,112,'BR',BrDim);
                    end;
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin
                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //    GetPostedDocDim("No.",0,112,'BR',BrDim);
                    end;
                end;
            }
            dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");

                trigger OnAfterGetRecord()
                begin

                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //GetPostedDocDim("No.",0,5744,'BR',BrDim);
                    end;
                end;
            }
            dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin

                    if "Shortcut Dimension 1 Code" <> BrDim then begin
                        "Shortcut Dimension 1 Code" := BrDim;
                        Modify;
                        //GetPostedDocDim("No.",0,5744,'BR',BrDim);
                    end;
                end;
            }
            dataitem(SALES; "G/L Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");
                DataItemTableView = where("G/L Account No." = filter('6100' .. '6195'));


                trigger OnAfterGetRecord()
                begin

                    if "Global Dimension 2 Code" <> BusDim then begin
                        "Global Dimension 2 Code" := BusDim;
                        Modify;
                        // GetLedgEntryDim("Entry No.",17,'BUS',BusDim);
                    end;
                    if "Global Dimension 1 Code" <> BrDim then begin
                        "Global Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetLedgEntryDim("Entry No.",17,'BR',BrDim);
                    end;

                    /*IF SalesDim <> '' THEN
                      GetLedgEntryDim("Entry No.",17,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem(PURCHASE; "G/L Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");
                DataItemTableView = where("G/L Account No." = filter('7100' .. '7195'));

                trigger OnAfterGetRecord()
                begin
                    if "Global Dimension 2 Code" <> BusDim then begin
                        "Global Dimension 2 Code" := BusDim;
                        Modify;
                        // GetLedgEntryDim("Entry No.",17,'BUS',BusDim);
                    end;
                    if "Global Dimension 1 Code" <> BrDim then begin
                        "Global Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetLedgEntryDim("Entry No.",17,'BR',BrDim);
                    end;

                    /*IF SalesDim <> '' THEN
                      GetLedgEntryDim("Entry No.",17,'SMAN',SalesDim);
                     */

                end;
            }
            dataitem(inventory; "G/L Entry")
            {
                DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");


                trigger OnAfterGetRecord()
                begin
                    if "Global Dimension 2 Code" <> BusDim then begin
                        "Global Dimension 2 Code" := BusDim;
                        Modify;
                        // GetLedgEntryDim("Entry No.",17,'BUS',BusDim);
                    end;
                    if "Global Dimension 1 Code" <> BrDim then begin
                        "Global Dimension 1 Code" := BrDim;
                        Modify;
                        //  GetLedgEntryDim("Entry No.",17,'BR',BrDim);
                    end;

                    /*IF SalesDim <> '' THEN
                      GetLedgEntryDim("Entry No.",17,'SMAN',SalesDim);
                     */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                Cnt += 1;
                if not DefDim.Get(27, "Item No.", 'PRODUCT') then;//CurrReport.SKIP;
                BusDim := DefDim."Dimension Value Code";

                Loc.Get("Location Code");
                DefDim.Get(50005, Loc."Responsibility Center", 'BRANCH');
                BrDim := DefDim."Dimension Value Code";

                if "Global Dimension 2 Code" <> BusDim then begin
                    "Global Dimension 2 Code" := BusDim;
                    Modify;

                    if "Value Entry"."Dimension Set ID" = 0 then begin
                        Message('hi');
                        if ("Value Entry"."Global Dimension 1 Code" <> '') then begin
                            DimeSet.Reset;
                            DimeSet.SetRange(DimeSet."Dimension Value Code", "Value Entry"."Global Dimension 1 Code");
                            if DimeSet.FindFirst then
                                repeat
                                    DimeSetID := DimeSet."Dimension Set ID";

                                    if ("Value Entry"."Global Dimension 2 Code" <> '') then begin
                                        DimeSet2.Reset;
                                        DimeSet2.SetRange(DimeSet2."Dimension Value Code", "Value Entry"."Global Dimension 2 Code");
                                        if DimeSet2.FindFirst then
                                            repeat
                                                DimeSetID2 := DimeSet2."Dimension Set ID";
                                                if DimeSetID = DimeSetID2 then begin
                                                    "Value Entry"."Dimension Set ID" := DimeSet."Dimension Set ID";
                                                    Message(DimeSet."Dimension Value Code");
                                                    Message(Format(DimeSet."Dimension Set ID"));
                                                    "Value Entry".Modify;
                                                end;
                                            until DimeSet2.Next = 0;
                                    end;
                                until DimeSet.Next = 0;
                        end;

                    end;
                end;





                //    GetLedgEntryDim("Entry No.",5802,'Product',BusDim);
                //END;
                if "Global Dimension 1 Code" <> BrDim then begin
                    "Global Dimension 1 Code" := BrDim;
                    Modify;
                    //    GetLedgEntryDim("Entry No.",5802,'BR',BrDim);
                end;

                /*SalesDim := '';
                IF "Salespers./Purch. Code" <> '' THEN
                  BEGIN
                    IF DefDim.GET(13,"Salespers./Purch. Code",'SMAN')
                    THEN SalesDim := DefDim."Dimension Value Code";
                    GetLedgEntryDim("Entry No.",5802,'SMAN',SalesDim);
                  END;
                 */
                Window.Update(1, ROUND(Cnt / TotCnt * 10000, 1));

            end;

            trigger OnPreDataItem()
            begin
                Window.Open('@1@@@@@@@@@@');
                TotCnt := "Value Entry".Count;
                Cnt := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        dd: Record "Dimension Set Entry";
        Loc: Record Location;
        BusDim: Code[20];
        BrDim: Code[20];
        Window: Dialog;
        Cnt: Integer;
        TotCnt: Integer;
        DefDim: Record "Default Dimension";
        SalesDim: Code[20];
        DimeSet: Record "Dimension Set Entry";
        DimeSet2: Record "Dimension Set Entry";
        DimeSetID: Integer;
        DimeSetID2: Integer;


    procedure GetLedgEntryDim()
    begin
    end;


    procedure CheckDimeSetId()
    begin
        /* IF "Value Entry"."Dimension Set ID"=0 THEN BEGIN
           IF ("Value Entry"."Global Dimension 1 Code"<>'') AND  ("Value Entry"."Global Dimension 2 Code" <> '') THEN
             DimeSet.RESET;
             DimeSet.SETRANGE(DimeSet."Dimension Value Code","Value Entry"."Global Dimension 1 Code");
             DimeSet.SETRANGE(DimeSet."Dimension Value Code","Value Entry"."Global Dimension 2 Code");
             IF DimeSet.FINDFIRST THEN
             "Value Entry"."Dimension Set ID":=DimeSet."Dimension Set ID";
              END;
         */

    end;
}

