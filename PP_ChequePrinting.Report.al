Report 50098 "PP_Cheque Printing"
{
    RDLCLayout = './Layouts/PP_ChequePrinting.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Bal. Account Type" = filter(Vendor));
            RequestFilterFields = "Document No.", "Entry No.";
            column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
            {
            }
            column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
            {
            }
            column(ChequeDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Cheque Date")
            {
            }
            column(Numbertext; Numbertext[1])
            {
            }
            column(Numbertext2; Numbertext[2])
            {
            }
            column(BearerName; "Bank Account Ledger Entry".Description)
            {
            }
            trigger OnAfterGetRecord();
            begin
                BearerName := '';
                GLEntry.SetRange(GLEntry."Document No.", "Bank Account Ledger Entry"."Document No.");
                LedgAmount := Abs("Bank Account Ledger Entry".Amount);
                ReportCheck.InitTextVariable;
                ReportCheck.FormatNoText(Numbertext, LedgAmount, "Bank Account Ledger Entry"."Currency Code");
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Document No.", "Bank Account Ledger Entry"."Document No.");
                GLEntry.SetRange(GLEntry."Posting Date", "Bank Account Ledger Entry"."Posting Date");
                //GLEntry.SETFILTER(GLEntry."Source Type",'<>%1',GLEntry."Source Type"::"Bank Account");
                if GLEntry.FindFirst then begin
                    repeat
                        if GLEntry."Source Type" = GLEntry."source type"::Vendor then begin
                            if vendor.Get(GLEntry."Source No.") then begin
                                BearerName := vendor.Name;
                            end;
                        end;
                        if GLEntry."Source Type" = GLEntry."source type"::Customer then begin
                            if Customer.Get(GLEntry."Source No.") then begin
                                BearerName := Customer.Name;
                            end;
                        end;
                    until (GLEntry.Next = 0) or (BearerName <> '');
                end;
            end;

            trigger OnPostDataItem();
            begin
                /*
				BearerName := '';
				IF BankAccount.GET("Bank Account Ledger Entry"."Bank Account No.") THEN BEGIN
				BankName:=BankAccount.Name;
				END;
				Dayint:= DATE2DMY("Bank Account Ledger Entry"."Posting Date",1);
				Monthint:=DATE2DMY("Bank Account Ledger Entry"."Posting Date",2);
				Yearint:=DATE2DMY("Bank Account Ledger Entry"."Posting Date",3);
				IF Dayint <=9 THEN
				  Daytext:='0'+FORMAT(Dayint)
				ELSE
				  Daytext:=FORMAT(Dayint);
				IF Monthint<=9 THEN
				  Monthtext:= '0'+FORMAT(Monthint)
				ELSE
				  Monthtext:=FORMAT(Monthint);
				  yeartext:=FORMAT(Yearint);
				  Text1:=COPYSTR(Daytext,1,1);
				  Text2:=COPYSTR(Daytext,2,1);
				  month1:=COPYSTR(Monthtext,1,1);
				  month2:=COPYSTR(Monthtext,2,1);
				  year1:=COPYSTR(yeartext,1,1);
				  year2:=COPYSTR(yeartext,2,1);
				  year3:=COPYSTR(yeartext,3,1);
				  year4:=COPYSTR(yeartext,4,1);
				LedgAmount:=ABS("Bank Account Ledger Entry".Amount);
				ReportCheck.InitTextVariable;
				ReportCheck.FormatNoText(Numbertext,LedgAmount,"Bank Account Ledger Entry"."Currency Code");
				// get the bearer name
				GLEntry.RESET;
				//GLEntry.SETRANGE(GLEntry."Entry No.","Bank Account Ledger Entry"."Entry No.");
				GLEntry.SETRANGE(GLEntry."Document No.","Bank Account Ledger Entry"."Document No.");
				GLEntry.SETRANGE(GLEntry."Posting Date","Bank Account Ledger Entry"."Posting Date");
				//GLEntry.SETFILTER(GLEntry."Source Type",'<>%1',GLEntry."Source Type"::"Bank Account");
				IF GLEntry.FINDFIRST THEN BEGIN
				  REPEAT
					  {
					  IF GLEntry."Source Type" = GLEntry."Source Type"::Vendor THEN BEGIN
						IF vendor.GET(GLEntry."Source No.") THEN BEGIN
						   BearerName:=vendor.Name;
						END;
					  END;
					  IF GLEntry."Source Type" = GLEntry."Source Type"::Customer THEN BEGIN
						IF Customer.GET(GLEntry."Source No.") THEN BEGIN
						   BearerName:=Customer.Name;
						END;
					  END;
					  }
					  //BearerName := GLEntry."Cheque Favouring To";
					  //BearerName :=
				  UNTIL (GLEntry.NEXT=0) OR (BearerName<>'');
				END;
				// if bearer name is blank then try to search in employee dimension
				{
				IF BearerName = '' THEN BEGIN
				   // SEARCH FOR EMPLOYEE DIMENSION IN THE DIMENSION SET
				   DimSetEntry.RESET;
				   IF DimSetEntry.GET("Bank Account Ledger Entry"."Dimension Set ID",'EMPLOYEE') THEN BEGIN
					  DimSetEntry.CALCFIELDS(DimSetEntry."Dimension Value Name");
					  BearerName := DimSetEntry."Dimension Value Name";
				   END;
				END;
				}
				//MESSAGE(BearerName);
				*/

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
                }
            }
        }

        actions
        {
        }
    }



    var
        Numbertext: array[5] of Text[100];
        ReportCheck: Report Check;
        Dayint: Integer;
        Monthint: Integer;
        Yearint: Integer;
        Daytext: Text[4];
        Monthtext: Text[4];
        yeartext: Text[4];
        Text1: Text;
        vendor: Record Vendor;
        Customer: Record Customer;
        BearerName: Text[100];
        LedgAmount: Decimal;
        Text2: Text;
        GLEntry: Record "G/L Entry";
        BankAccount: Record "Bank Account";
        BankName: Text;
        DimSetEntry: Record "Dimension Set Entry";

}