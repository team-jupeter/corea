defmodule CoreaWeb.Router do
  use CoreaWeb, :router

  import CoreaWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CoreaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CoreaWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/nations", NationLive.Index, :index
    live "/nations/new", NationLive.Index, :new
    live "/nations/:id/edit", NationLive.Index, :edit

    live "/nations/:id", NationLive.Show, :show
    live "/nations/:id/show/edit", NationLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/constitutions", ConstitutionLive.Index, :index
    live "/constitutions/new", ConstitutionLive.Index, :new
    live "/constitutions/:id/edit", ConstitutionLive.Index, :edit

    live "/constitutions/:id", ConstitutionLive.Show, :show
    live "/constitutions/:id/show/edit", ConstitutionLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/global_supuls", GlobalSupulLive.Index, :index
    live "/global_supuls/new", GlobalSupulLive.Index, :new
    live "/global_supuls/:id/edit", GlobalSupulLive.Index, :edit

    live "/global_supuls/:id", GlobalSupulLive.Show, :show
    live "/global_supuls/:id/show/edit", GlobalSupulLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/nation_supuls", NationSupulLive.Index, :index
    live "/nation_supuls/new", NationSupulLive.Index, :new
    live "/nation_supuls/:id/edit", NationSupulLive.Index, :edit

    live "/nation_supuls/:id", NationSupulLive.Show, :show
    live "/nation_supuls/:id/show/edit", NationSupulLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/state_supuls", StateSupulLive.Index, :index
    live "/state_supuls/new", StateSupulLive.Index, :new
    live "/state_supuls/:id/edit", StateSupulLive.Index, :edit

    live "/state_supuls/:id", StateSupulLive.Show, :show
    live "/state_supuls/:id/show/edit", StateSupulLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/supuls", SupulLive.Index, :index
    live "/supuls/new", SupulLive.Index, :new
    live "/supuls/:id/edit", SupulLive.Index, :edit

    live "/supuls/:id", SupulLive.Show, :show
    live "/supuls/:id/show/edit", SupulLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/schools", SchoolLive.Index, :index
    live "/schools/new", SchoolLive.Index, :new
    live "/schools/:id/edit", SchoolLive.Index, :edit

    live "/schools/:id", SchoolLive.Show, :show
    live "/schools/:id/show/edit", SchoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gabs", GABLive.Index, :index
    live "/gabs/new", GABLive.Index, :new
    live "/gabs/:id/edit", GABLive.Index, :edit

    live "/gabs/:id", GABLive.Show, :show
    live "/gabs/:id/show/edit", GABLive.Show, :edit

  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/families", FamilyLive.Index, :index
    live "/families/new", FamilyLive.Index, :new
    live "/families/:id/edit", FamilyLive.Index, :edit

    live "/families/:id", FamilyLive.Show, :show
    live "/families/:id/show/edit", FamilyLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/taxations", TaxationLive.Index, :index
    live "/taxations/new", TaxationLive.Index, :new
    live "/taxations/:id/edit", TaxationLive.Index, :edit

    live "/taxations/:id", TaxationLive.Show, :show
    live "/taxations/:id/show/edit", TaxationLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gpc_codes", GPCCodeLive.Index, :index
    live "/gpc_codes/new", GPCCodeLive.Index, :new
    live "/gpc_codes/:id/edit", GPCCodeLive.Index, :edit

    live "/gpc_codes/:id", GPCCodeLive.Show, :show
    live "/gpc_codes/:id/show/edit", GPCCodeLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/biz_categories", BizCategoryLive.Index, :index
    live "/biz_categories/new", BizCategoryLive.Index, :new
    live "/biz_categories/:id/edit", BizCategoryLive.Index, :edit

    live "/biz_categories/:id", BizCategoryLive.Show, :show
    live "/biz_categories/:id/show/edit", BizCategoryLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/groups", GroupLive.Index, :index
    live "/groups/new", GroupLive.Index, :new
    live "/groups/:id/edit", GroupLive.Index, :edit

    live "/groups/:id", GroupLive.Show, :show
    live "/groups/:id/show/edit", GroupLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/entities", EntityLive.Index, :index
    live "/entities/new", EntityLive.Index, :new
    live "/entities/:id/edit", EntityLive.Index, :edit

    live "/entities/:id", EntityLive.Show, :show
    live "/entities/:id/show/edit", EntityLive.Show, :edit

  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/invoices", InvoiceLive.Index, :index
    live "/invoices/new", InvoiceLive.Index, :new
    live "/invoices/:id/edit", InvoiceLive.Index, :edit

    live "/invoices/:id", InvoiceLive.Show, :show
    live "/invoices/:id/show/edit", InvoiceLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/txns", TxnLive.Index, :index
    live "/txns/new", TxnLive.Index, :new
    live "/txns/:id/edit", TxnLive.Index, :edit

    live "/txns/:id", TxnLive.Show, :show
    live "/txns/:id/show/edit", TxnLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/product_annotations", ProductAnnotationLive.Index, :index
    live "/product_annotations/new", ProductAnnotationLive.Index, :new
    live "/product_annotations/:id/edit", ProductAnnotationLive.Index, :edit

    live "/product_annotations/:id", ProductAnnotationLive.Show, :show
    live "/product_annotations/:id/show/edit", ProductAnnotationLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/tax_rates", TaxRateLive.Index, :index
    live "/tax_rates/new", TaxRateLive.Index, :new
    live "/tax_rates/:id/edit", TaxRateLive.Index, :edit

    live "/tax_rates/:id", TaxRateLive.Show, :show
    live "/tax_rates/:id/show/edit", TaxRateLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser

  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/color_codes", ColorCodeLive.Index, :index
    live "/color_codes/new", ColorCodeLive.Index, :new
    live "/color_codes/:id/edit", ColorCodeLive.Index, :edit

    live "/color_codes/:id", ColorCodeLive.Show, :show
    live "/color_codes/:id/show/edit", ColorCodeLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/items", ItemLive.Index, :index
    live "/items/new", ItemLive.Index, :new
    live "/items/:id/edit", ItemLive.Index, :edit

    live "/items/:id", ItemLive.Show, :show
    live "/items/:id/show/edit", ItemLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/invoice_items", InvoiceItemLive.Index, :index
    live "/invoice_items/new", InvoiceItemLive.Index, :new
    live "/invoice_items/:id/edit", InvoiceItemLive.Index, :edit

    live "/invoice_items/:id", InvoiceItemLive.Show, :show
    live "/invoice_items/:id/show/edit", InvoiceItemLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser

  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/health_reports", HealthReportLive.Index, :index
    live "/health_reports/new", HealthReportLive.Index, :new
    live "/health_reports/:id/edit", HealthReportLive.Index, :edit

    live "/health_reports/:id", HealthReportLive.Show, :show
    live "/health_reports/:id/show/edit", HealthReportLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/teams", TeamLive.Index, :index
    live "/teams/new", TeamLive.Index, :new
    live "/teams/:id/edit", TeamLive.Index, :edit

    live "/teams/:id", TeamLive.Show, :show
    live "/teams/:id/show/edit", TeamLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/financial_reports", FinancialReportLive.Index, :index
    live "/financial_reports/new", FinancialReportLive.Index, :new
    live "/financial_reports/:id/edit", FinancialReportLive.Index, :edit

    live "/financial_reports/:id", FinancialReportLive.Show, :show
    live "/financial_reports/:id/show/edit", FinancialReportLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gab_balance_sheets", GABBalanceSheetLive.Index, :index
    live "/gab_balance_sheets/new", GABBalanceSheetLive.Index, :new
    live "/gab_balance_sheets/:id/edit", GABBalanceSheetLive.Index, :edit

    live "/gab_balance_sheets/:id", GABBalanceSheetLive.Show, :show
    live "/gab_balance_sheets/:id/show/edit", GABBalanceSheetLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser

  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/balance_sheets", BalanceSheetLive.Index, :index
    live "/balance_sheets/new", BalanceSheetLive.Index, :new
    live "/balance_sheets/:id/edit", BalanceSheetLive.Index, :edit

    live "/balance_sheets/:id", BalanceSheetLive.Show, :show
    live "/balance_sheets/:id/show/edit", BalanceSheetLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/cf_statements", CFStatementLive.Index, :index
    live "/cf_statements/new", CFStatementLive.Index, :new
    live "/cf_statements/:id/edit", CFStatementLive.Index, :edit

    live "/cf_statements/:id", CFStatementLive.Show, :show
    live "/cf_statements/:id/show/edit", CFStatementLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/income_statements", IncomeStatementLive.Index, :index
    live "/income_statements/new", IncomeStatementLive.Index, :new
    live "/income_statements/:id/edit", IncomeStatementLive.Index, :edit

    live "/income_statements/:id", IncomeStatementLive.Show, :show
    live "/income_statements/:id/show/edit", IncomeStatementLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gov_balance_sheets", GovBalanceSheetLive.Index, :index
    live "/gov_balance_sheets/new", GovBalanceSheetLive.Index, :new
    live "/gov_balance_sheets/:id/edit", GovBalanceSheetLive.Index, :edit

    live "/gov_balance_sheets/:id", GovBalanceSheetLive.Show, :show
    live "/gov_balance_sheets/:id/show/edit", GovBalanceSheetLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gopang_balance_sheets", GopangBalanceSheetLive.Index, :index
    live "/gopang_balance_sheets/new", GopangBalanceSheetLive.Index, :new
    live "/gopang_balance_sheets/:id/edit", GopangBalanceSheetLive.Index, :edit

    live "/gopang_balance_sheets/:id", GopangBalanceSheetLive.Show, :show
    live "/gopang_balance_sheets/:id/show/edit", GopangBalanceSheetLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/supul_balance_sheets", SupulBalanceSheetLive.Index, :index
    live "/supul_balance_sheets/new", SupulBalanceSheetLive.Index, :new
    live "/supul_balance_sheets/:id/edit", SupulBalanceSheetLive.Index, :edit

    live "/supul_balance_sheets/:id", SupulBalanceSheetLive.Show, :show
    live "/supul_balance_sheets/:id/show/edit", SupulBalanceSheetLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/equity_statements", EquityStatementLive.Index, :index
    live "/equity_statements/new", EquityStatementLive.Index, :new
    live "/equity_statements/:id/edit", EquityStatementLive.Index, :edit

    live "/equity_statements/:id", EquityStatementLive.Show, :show
    live "/equity_statements/:id/show/edit", EquityStatementLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/account_books", AccountBookLive.Index, :index
    live "/account_books/new", AccountBookLive.Index, :new
    live "/account_books/:id/edit", AccountBookLive.Index, :edit

    live "/account_books/:id", AccountBookLive.Show, :show
    live "/account_books/:id/show/edit", AccountBookLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/polices", PoliceLive.Index, :index
    live "/polices/new", PoliceLive.Index, :new
    live "/polices/:id/edit", PoliceLive.Index, :edit

    live "/polices/:id", PoliceLive.Show, :show
    live "/polices/:id/show/edit", PoliceLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/bio_data", BioDatumLive.Index, :index
    live "/bio_data/new", BioDatumLive.Index, :new
    live "/bio_data/:id/edit", BioDatumLive.Index, :edit

    live "/bio_data/:id", BioDatumLive.Show, :show
    live "/bio_data/:id/show/edit", BioDatumLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/addresses", AddressLive.Index, :index
    live "/addresses/new", AddressLive.Index, :new
    live "/addresses/:id/edit", AddressLive.Index, :edit

    live "/addresses/:id", AddressLive.Show, :show
    live "/addresses/:id/show/edit", AddressLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/transports", TransportLive.Index, :index
    live "/transports/new", TransportLive.Index, :new
    live "/transports/:id/edit", TransportLive.Index, :edit

    live "/transports/:id", TransportLive.Show, :show
    live "/transports/:id/show/edit", TransportLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/terminals", TerminalLive.Index, :index
    live "/terminals/new", TerminalLive.Index, :new
    live "/terminals/:id/edit", TerminalLive.Index, :edit

    live "/terminals/:id", TerminalLive.Show, :show
    live "/terminals/:id/show/edit", TerminalLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/cars", CarLive.Index, :index
    live "/cars/new", CarLive.Index, :new
    live "/cars/:id/edit", CarLive.Index, :edit

    live "/cars/:id", CarLive.Show, :show
    live "/cars/:id/show/edit", CarLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/tickets", TicketLive.Index, :index
    live "/tickets/new", TicketLive.Index, :new
    live "/tickets/:id/edit", TicketLive.Index, :edit

    live "/tickets/:id", TicketLive.Show, :show
    live "/tickets/:id/show/edit", TicketLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/geo_logs", GeoLogLive.Index, :index
    live "/geo_logs/new", GeoLogLive.Index, :new
    live "/geo_logs/:id/edit", GeoLogLive.Index, :edit

    live "/geo_logs/:id", GeoLogLive.Show, :show
    live "/geo_logs/:id/show/edit", GeoLogLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/prescriptions", PrescriptionLive.Index, :index
    live "/prescriptions/new", PrescriptionLive.Index, :new
    live "/prescriptions/:id/edit", PrescriptionLive.Index, :edit

    live "/prescriptions/:id", PrescriptionLive.Show, :show
    live "/prescriptions/:id/show/edit", PrescriptionLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/treatments", TreatmentLive.Index, :index
    live "/treatments/new", TreatmentLive.Index, :new
    live "/treatments/:id/edit", TreatmentLive.Index, :edit

    live "/treatments/:id", TreatmentLive.Show, :show
    live "/treatments/:id/show/edit", TreatmentLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/licenses", LicenseLive.Index, :index
    live "/licenses/new", LicenseLive.Index, :new
    live "/licenses/:id/edit", LicenseLive.Index, :edit

    live "/licenses/:id", LicenseLive.Show, :show
    live "/licenses/:id/show/edit", LicenseLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/financial_accounts", FinancialAccountLive.Index, :index
    live "/financial_accounts/new", FinancialAccountLive.Index, :new
    live "/financial_accounts/:id/edit", FinancialAccountLive.Index, :edit

    live "/financial_accounts/:id", FinancialAccountLive.Show, :show
    live "/financial_accounts/:id/show/edit", FinancialAccountLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/reservoirs", ReservoirLive.Index, :index
    live "/reservoirs/new", ReservoirLive.Index, :new
    live "/reservoirs/:id/edit", ReservoirLive.Index, :edit

    live "/reservoirs/:id", ReservoirLive.Show, :show
    live "/reservoirs/:id/show/edit", ReservoirLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/sils", SilLive.Index, :index
    live "/sils/new", SilLive.Index, :new
    live "/sils/:id/edit", SilLive.Index, :edit

    live "/sils/:id", SilLive.Show, :show
    live "/sils/:id/show/edit", SilLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gopangs", GopangLive.Index, :index
    live "/gopangs/new", GopangLive.Index, :new
    live "/gopangs/:id/edit", GopangLive.Index, :edit

    live "/gopangs/:id", GopangLive.Show, :show
    live "/gopangs/:id/show/edit", GopangLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/traffics", TrafficLive.Index, :index
    live "/traffics/new", TrafficLive.Index, :new
    live "/traffics/:id/edit", TrafficLive.Index, :edit

    live "/traffics/:id", TrafficLive.Show, :show
    live "/traffics/:id/show/edit", TrafficLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/real_estates", RealEstateLive.Index, :index
    live "/real_estates/new", RealEstateLive.Index, :new
    live "/real_estates/:id/edit", RealEstateLive.Index, :edit

    live "/real_estates/:id", RealEstateLive.Show, :show
    live "/real_estates/:id/show/edit", RealEstateLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/applicants", ApplicantLive.Index, :index
    live "/applicants/new", ApplicantLive.Index, :new
    live "/applicants/:id/edit", ApplicantLive.Index, :edit

    live "/applicants/:id", ApplicantLive.Show, :show
    live "/applicants/:id/show/edit", ApplicantLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/subjects", SubjectLive.Index, :index
    live "/subjects/new", SubjectLive.Index, :new
    live "/subjects/:id/edit", SubjectLive.Index, :edit

    live "/subjects/:id", SubjectLive.Show, :show
    live "/subjects/:id/show/edit", SubjectLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/documents", DocumentLive.Index, :index
    live "/documents/new", DocumentLive.Index, :new
    live "/documents/:id/edit", DocumentLive.Index, :edit

    live "/documents/:id", DocumentLive.Show, :show
    live "/documents/:id/show/edit", DocumentLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/patents", PatentLive.Index, :index
    live "/patents/new", PatentLive.Index, :new
    live "/patents/:id/edit", PatentLive.Index, :edit

    live "/patents/:id", PatentLive.Show, :show
    live "/patents/:id/show/edit", PatentLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/patent_applications", PatentApplicationLive.Index, :index
    live "/patent_applications/new", PatentApplicationLive.Index, :new
    live "/patent_applications/:id/edit", PatentApplicationLive.Index, :edit

    live "/patent_applications/:id", PatentApplicationLive.Show, :show
    live "/patent_applications/:id/show/edit", PatentApplicationLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/disease_controls", DiseaseControlLive.Index, :index
    live "/disease_controls/new", DiseaseControlLive.Index, :new
    live "/disease_controls/:id/edit", DiseaseControlLive.Index, :edit

    live "/disease_controls/:id", DiseaseControlLive.Show, :show
    live "/disease_controls/:id/show/edit", DiseaseControlLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/diagnoses", DiagnosisLive.Index, :index
    live "/diagnoses/new", DiagnosisLive.Index, :new
    live "/diagnoses/:id/edit", DiagnosisLive.Index, :edit

    live "/diagnoses/:id", DiagnosisLive.Show, :show
    live "/diagnoses/:id/show/edit", DiagnosisLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/metabolic_panels", MetabolicPanelLive.Index, :index
    live "/metabolic_panels/new", MetabolicPanelLive.Index, :new
    live "/metabolic_panels/:id/edit", MetabolicPanelLive.Index, :edit

    live "/metabolic_panels/:id", MetabolicPanelLive.Show, :show
    live "/metabolic_panels/:id/show/edit", MetabolicPanelLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/machines", MachineLive.Index, :index
    live "/machines/new", MachineLive.Index, :new
    live "/machines/:id/edit", MachineLive.Index, :edit

    live "/machines/:id", MachineLive.Show, :show
    live "/machines/:id/show/edit", MachineLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/labs", LabLive.Index, :index
    live "/labs/new", LabLive.Index, :new
    live "/labs/:id/edit", LabLive.Index, :edit

    live "/labs/:id", LabLive.Show, :show
    live "/labs/:id/show/edit", LabLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/students", StudentLive.Index, :index
    live "/students/new", StudentLive.Index, :new
    live "/students/:id/edit", StudentLive.Index, :edit

    live "/students/:id", StudentLive.Show, :show
    live "/students/:id/show/edit", StudentLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/laws", LawLive.Index, :index
    live "/laws/new", LawLive.Index, :new
    live "/laws/:id/edit", LawLive.Index, :edit

    live "/laws/:id", LawLive.Show, :show
    live "/laws/:id/show/edit", LawLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/ordinances", OrdinanceLive.Index, :index
    live "/ordinances/new", OrdinanceLive.Index, :new
    live "/ordinances/:id/edit", OrdinanceLive.Index, :edit

    live "/ordinances/:id", OrdinanceLive.Show, :show
    live "/ordinances/:id/show/edit", OrdinanceLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/rules", RuleLive.Index, :index
    live "/rules/new", RuleLive.Index, :new
    live "/rules/:id/edit", RuleLive.Index, :edit

    live "/rules/:id", RuleLive.Show, :show
    live "/rules/:id/show/edit", RuleLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/votes", VoteLive.Index, :index
    live "/votes/new", VoteLive.Index, :new
    live "/votes/:id/edit", VoteLive.Index, :edit

    live "/votes/:id", VoteLive.Show, :show
    live "/votes/:id/show/edit", VoteLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/initiatives", InitiativeLive.Index, :index
    live "/initiatives/new", InitiativeLive.Index, :new
    live "/initiatives/:id/edit", InitiativeLive.Index, :edit

    live "/initiatives/:id", InitiativeLive.Show, :show
    live "/initiatives/:id/show/edit", InitiativeLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit

    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/videos", VideoLive.Index, :index
    live "/videos/new", VideoLive.Index, :new
    live "/videos/:id/edit", VideoLive.Index, :edit

    live "/videos/:id", VideoLive.Show, :show
    live "/videos/:id/show/edit", VideoLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/annotations", AnnotationLive.Index, :index
    live "/annotations/new", AnnotationLive.Index, :new
    live "/annotations/:id/edit", AnnotationLive.Index, :edit

    live "/annotations/:id", AnnotationLive.Show, :show
    live "/annotations/:id/show/edit", AnnotationLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/assets", AssetLive.Index, :index
    live "/assets/new", AssetLive.Index, :new
    live "/assets/:id/edit", AssetLive.Index, :edit

    live "/assets/:id", AssetLive.Show, :show
    live "/assets/:id/show/edit", AssetLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/payload_archives", PayloadArchiveLive.Index, :index
    live "/payload_archives/new", PayloadArchiveLive.Index, :new
    live "/payload_archives/:id/edit", PayloadArchiveLive.Index, :edit

    live "/payload_archives/:id", PayloadArchiveLive.Show, :show
    live "/payload_archives/:id/show/edit", PayloadArchiveLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/payloads", PayloadLive.Index, :index
    live "/payloads/new", PayloadLive.Index, :new
    live "/payloads/:id/edit", PayloadLive.Index, :edit

    live "/payloads/:id", PayloadLive.Show, :show
    live "/payloads/:id/show/edit", PayloadLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/certificates", CertificateLive.Index, :index
    live "/certificates/new", CertificateLive.Index, :new
    live "/certificates/:id/edit", CertificateLive.Index, :edit

    live "/certificates/:id", CertificateLive.Show, :show
    live "/certificates/:id/show/edit", CertificateLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/weddings", WeddingLive.Index, :index
    live "/weddings/new", WeddingLive.Index, :new
    live "/weddings/:id/edit", WeddingLive.Index, :edit

    live "/weddings/:id", WeddingLive.Show, :show
    live "/weddings/:id/show/edit", WeddingLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/openhashes", OpenhashLive.Index, :index
    live "/openhashes/new", OpenhashLive.Index, :new
    live "/openhashes/:id/edit", OpenhashLive.Index, :edit

    live "/openhashes/:id", OpenhashLive.Show, :show
    live "/openhashes/:id/show/edit", OpenhashLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.Index, :new
    live "/events/:id/edit", EventLive.Index, :edit

    live "/events/:id", EventLive.Show, :show
    live "/events/:id/show/edit", EventLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/gab_accounts", GABAccountLive.Index, :index
    live "/gab_accounts/new", GABAccountLive.Index, :new
    live "/gab_accounts/:id/edit", GABAccountLive.Index, :edit

    live "/gab_accounts/:id", GABAccountLive.Show, :show
    live "/gab_accounts/:id/show/edit", GABAccountLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/money_pools", MoneyPoolLive.Index, :index
    live "/money_pools/new", MoneyPoolLive.Index, :new
    live "/money_pools/:id/edit", MoneyPoolLive.Index, :edit

    live "/money_pools/:id", MoneyPoolLive.Show, :show
    live "/money_pools/:id/show/edit", MoneyPoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t1s", T1Live.Index, :index
    live "/t1s/new", T1Live.Index, :new
    live "/t1s/:id/edit", T1Live.Index, :edit

    live "/t1s/:id", T1Live.Show, :show
    live "/t1s/:id/show/edit", T1Live.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t2s", T2Live.Index, :index
    live "/t2s/new", T2Live.Index, :new
    live "/t2s/:id/edit", T2Live.Index, :edit

    live "/t2s/:id", T2Live.Show, :show
    live "/t2s/:id/show/edit", T2Live.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t3s", T3Live.Index, :index
    live "/t3s/new", T3Live.Index, :new
    live "/t3s/:id/edit", T3Live.Index, :edit

    live "/t3s/:id", T3Live.Show, :show
    live "/t3s/:id/show/edit", T3Live.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t4s", T4Live.Index, :index
    live "/t4s/new", T4Live.Index, :new
    live "/t4s/:id/edit", T4Live.Index, :edit

    live "/t4s/:id", T4Live.Show, :show
    live "/t4s/:id/show/edit", T4Live.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t5s", T5Live.Index, :index
    live "/t5s/new", T5Live.Index, :new
    live "/t5s/:id/edit", T5Live.Index, :edit

    live "/t5s/:id", T5Live.Show, :show
    live "/t5s/:id/show/edit", T5Live.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/fiat_pools", FiatPoolLive.Index, :index
    live "/fiat_pools/new", FiatPoolLive.Index, :new
    live "/fiat_pools/:id/edit", FiatPoolLive.Index, :edit

    live "/fiat_pools/:id", FiatPoolLive.Show, :show
    live "/fiat_pools/:id/show/edit", FiatPoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t1_pools", T1PoolLive.Index, :index
    live "/t1_pools/new", T1PoolLive.Index, :new
    live "/t1_pools/:id/edit", T1PoolLive.Index, :edit

    live "/t1_pools/:id", T1PoolLive.Show, :show
    live "/t1_pools/:id/show/edit", T1PoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t2_pools", T2PoolLive.Index, :index
    live "/t2_pools/new", T2PoolLive.Index, :new
    live "/t2_pools/:id/edit", T2PoolLive.Index, :edit

    live "/t2_pools/:id", T2PoolLive.Show, :show
    live "/t2_pools/:id/show/edit", T2PoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t3_pools", T3PoolLive.Index, :index
    live "/t3_pools/new", T3PoolLive.Index, :new
    live "/t3_pools/:id/edit", T3PoolLive.Index, :edit

    live "/t3_pools/:id", T3PoolLive.Show, :show
    live "/t3_pools/:id/show/edit", T3PoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/t4_pools", T4PoolLive.Index, :index
    live "/t4_pools/new", T4PoolLive.Index, :new
    live "/t4_pools/:id/edit", T4PoolLive.Index, :edit

    live "/t4_pools/:id", T4PoolLive.Show, :show
    live "/t4_pools/:id/show/edit", T4PoolLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/transfers", TransferLive.Index, :index
    live "/transfers/new", TransferLive.Index, :new
    live "/transfers/:id/edit", TransferLive.Index, :edit

    live "/transfers/:id", TransferLive.Show, :show
    live "/transfers/:id/show/edit", TransferLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/deposits", DepositLive.Index, :index
    live "/deposits/new", DepositLive.Index, :new
    live "/deposits/:id/edit", DepositLive.Index, :edit

    live "/deposits/:id", DepositLive.Show, :show
    live "/deposits/:id/show/edit", DepositLive.Show, :edit
  end
  scope "/", CoreaWeb do
    pipe_through :browser
    live "/withdrawals", WithdrawalLive.Index, :index
    live "/withdrawals/new", WithdrawalLive.Index, :new
    live "/withdrawals/:id/edit", WithdrawalLive.Index, :edit

    live "/withdrawals/:id", WithdrawalLive.Show, :show
    live "/withdrawals/:id/show/edit", WithdrawalLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", CoreaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CoreaWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", CoreaWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", CoreaWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings/update_password", UserSettingsController, :update_password
    put "/users/settings/update_email", UserSettingsController, :update_email
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", CoreaWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
