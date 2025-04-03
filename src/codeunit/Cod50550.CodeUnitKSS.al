codeunit 50550 "CodeUnit_KSS"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforePerformManualRelease, '', false, false)]
    local procedure MyProcedure(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        customer: Record Customer;
    begin
        customer.Reset();
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
        customer.Reset();
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
        customer.Reset();
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
    end;


}