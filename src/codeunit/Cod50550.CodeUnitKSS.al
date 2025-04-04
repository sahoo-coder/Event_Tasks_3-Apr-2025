codeunit 50550 "CodeUnit_KSS"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforePerformManualRelease, '', false, false)]
    local procedure MyProcedure(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        customer: Record Customer;
    begin
        // customer.Reset(); (No Need for Reset)
        customer.Get(SalesHeader."Sell-to Customer No.");
        if customer."Hold on Customer" then
            IsHandled := true;

        if IsHandled then
            Message('🙄CUSTOMER IS ON HOLD. CAN NOT RELEASE THE ORDER🥶');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforePerformManualReleaseProcedure, '', false, false)]
    local procedure MyProcedure2(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        customer: Record Customer;
    begin
        // customer.Reset(); (No Need for Reset)
        customer.Get(SalesHeader."Sell-to Customer No.");
        if customer."Hold on Customer" then
            IsHandled := true;

        if IsHandled then
            Message('🙄CUSTOMER IS ON HOLD. CAN NOT RELEASE THE INVOICE🥶');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeSendToPosting, '', false, false)]
    local procedure MyProcedure3(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var IsSuccess: Boolean)
    var
        customer: Record Customer;
    begin
        // customer.Reset(); (No Need for Reset)
        customer.Get(SalesHeader."Sell-to Customer No.");
        if customer."Hold on Customer" then begin
            IsHandled := true;
            IsSuccess := true;
        end;

        if IsHandled then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                Message('🙄CUSTOMER IS ON HOLD. CAN NOT POST THE ORDER🥶');

        if IsHandled then
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                Message('🙄CUSTOMER IS ON HOLD. CAN NOT POST THE INVOICE🥶');

        //TASK2 started from here
        if not IsHandled then begin
            if SalesHeader.SO_HEADER_KSS = '' then begin
                IsHandled := true;
                IsSuccess := true;
            end;
            if IsHandled then
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                    Message('THE FIELD SO HEADER KSS CAN NOT BE EMPTY🙄!!! POSTING OF ORDER NOT ALLOWED!!!');

            if IsHandled then
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    Message('THE FIELD SO HEADER KSS CAN NOT BE EMPTY🙄!!! POSTING OF INVOICE NOT ALLOWED!!!');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnBeforeNoOnAfterValidate, '', false, false)]
    local procedure MyProcedure4(var SalesLine: Record "Sales Line")
    var
        salesHeader: Record "Sales Header";
    begin
        if SalesLine.Type = SalesLine.Type::Item then begin
            salesHeader.Reset();
            salesHeader.SetRange("Document Type", salesHeader."Document Type"::Order);

            salesHeader.SetRange("No.", SalesLine."Document No.");

            if salesHeader.FindFirst() then begin
                if salesHeader.SO_HEADER_KSS <> '' then begin
                    SalesLine.SO_Line_KSS := salesHeader.SO_HEADER_KSS;
                end;
            end;
        end;
    end;




}