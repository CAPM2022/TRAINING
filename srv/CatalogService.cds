using { epm.db, epm.db.CDSViews, ZCV_MY_FIRSTCALC_VIEW } from  '../db/datamodel';


service CatalogService@(path:'/CatalogService') 
                @(requires: 'authenticated-user')  
                {
    @Capabilities : { Insertable, Updatable , Deletable }
     entity EmployeeSet 
    @(restrict: [ 
    { grant: ['READ'], to: 'Viewer',
      where: 'bankName = $user.BankName' },
    ])
     as projection on db.master.employees;

    entity AddressSet as projection on db.master.address;

    entity ProductSet as projection on db.master.product;

    entity BPSet as projection on db.master.businesspartner;

    entity POs @(
        title: '{i18n>poHeader}'
    ) as projection on db.transaction.purchaseorder{
        *,
        Items: redirected to POItems
    }

    entity POItems @( title : '{i18n>poItems}' )
    as projection on db.transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }

    entity POWorklist as projection on CDSViews.POWorklist;
    entity ProductOrders as projection on CDSViews.ProductViewSub;
    entity ProductAggregation as projection on CDSViews.CProductValuesView excluding{
        ProductId
    };

    // Calculation View as service
    @readonly
    entity ProdCV as projection on ZCV_MY_FIRSTCALC_VIEW;
}