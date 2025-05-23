open InsightsTypes
open InsightsHelper
open InsightsRefundsAnalyticsEntity
open BarGraphTypes
open FailedRefundsDistributionUtils
open FailedRefundsDistributionTypes

module TableModule = {
  @react.component
  let make = (~data, ~className="") => {
    let (offset, setOffset) = React.useState(_ => 0)
    let defaultSort: Table.sortedObject = {
      key: "",
      order: Table.INC,
    }

    let visibleColumns = [Connector, Refunds_Failure_Rate]
    let tableData = getTableData(data)

    <div className>
      <LoadedTable
        visibleColumns
        title="Failed Refunds Distribution"
        hideTitle=true
        actualData={tableData}
        entity=failedRefundsDistributionTableEntity
        resultsPerPage=10
        totalResults={tableData->Array.length}
        offset
        setOffset
        defaultSort
        currrentFetchCount={tableData->Array.length}
        tableLocalFilter=false
        tableheadingClass=tableBorderClass
        tableBorderClass
        ignoreHeaderBg=true
        tableDataBorderClass=tableBorderClass
        isAnalyticsModule=true
      />
    </div>
  }
}

module FailedRefundsDistributionHeader = {
  @react.component
  let make = (~viewType, ~setViewType) => {
    let setViewType = value => {
      setViewType(_ => value)
    }
    <div className="w-full px-8 pt-3 pb-3  flex justify-end">
      <div className="flex gap-2">
        <TabSwitch viewType setViewType />
      </div>
    </div>
  }
}

@react.component
let make = (
  ~entity: moduleEntity,
  ~chartEntity: chartEntity<barGraphPayload, barGraphOptions, JSON.t>,
) => {
  open LogicUtils
  open APIUtils
  open InsightsUtils
  open InsightsContainerUtils
  let getURL = useGetURL()
  let fetchApi = AuthHooks.useApiFetcher()
  let updateDetails = useUpdateMethod()
  let {filterValueJson} = React.useContext(FilterContext.filterContext)
  let (screenState, setScreenState) = React.useState(_ => PageLoaderWrapper.Loading)
  let isSampleDataEnabled = filterValueJson->getStringFromDictAsBool(sampleDataKey, false)
  let (refundsDistribution, setrefundsDistribution) = React.useState(_ => JSON.Encode.array([]))
  let (viewType, setViewType) = React.useState(_ => Graph)
  let startTimeVal = filterValueJson->getString("startTime", "")
  let endTimeVal = filterValueJson->getString("endTime", "")
  let currency = filterValueJson->getString((#currency: filters :> string), "")

  let getRefundsDistribution = async () => {
    setScreenState(_ => PageLoaderWrapper.Loading)
    try {
      let url = getURL(
        ~entityName=V1(ANALYTICS_REFUNDS),
        ~methodType=Post,
        ~id=Some((entity.domain: domain :> string)),
      )

      let response = if isSampleDataEnabled {
        let refundsUrl = `${GlobalVars.getHostUrl}/test-data/analytics/refunds.json`
        let res = await fetchApi(
          refundsUrl,
          ~method_=Get,
          ~xFeatureRoute=false,
          ~forceCookies=false,
        )
        let refundsResponse = await res->(res => res->Fetch.Response.json)
        refundsResponse
        ->getDictFromJsonObject
        ->getJsonObjectFromDict("refundConnectorsSampleData")
      } else {
        let body = requestBody(
          ~startTime=startTimeVal,
          ~endTime=endTimeVal,
          ~delta=entity.requestBodyConfig.delta,
          ~metrics=entity.requestBodyConfig.metrics,
          ~groupByNames=[Connector->getStringFromVariant]->Some,
          ~filter=generateFilterObject(~globalFilters=filterValueJson)->Some,
        )
        await updateDetails(url, body, Post)
      }

      let responseTotalNumberData =
        response->getDictFromJsonObject->getArrayFromDict("queryData", [])
      if responseTotalNumberData->Array.length > 0 {
        let response = if isSampleDataEnabled {
          let refundsUrl = `${GlobalVars.getHostUrl}/test-data/analytics/refunds.json`
          let res = await fetchApi(
            refundsUrl,
            ~method_=Get,
            ~xFeatureRoute=false,
            ~forceCookies=false,
          )
          let refundsResponse = await res->(res => res->Fetch.Response.json)
          refundsResponse
          ->getDictFromJsonObject
          ->getJsonObjectFromDict("refundFailedConnectorsSampleData")
        } else {
          let filters = Dict.make()
          filters->Dict.set("refund_status", ["failure"->JSON.Encode.string]->JSON.Encode.array)
          let body = requestBody(
            ~startTime=startTimeVal,
            ~endTime=endTimeVal,
            ~filter=generateFilterObject(
              ~globalFilters=filterValueJson,
              ~localFilters=filters->Some,
            )->Some,
            ~delta=entity.requestBodyConfig.delta,
            ~metrics=entity.requestBodyConfig.metrics,
            ~groupByNames=[Connector->getStringFromVariant]->Some,
          )
          await updateDetails(url, body, Post)
        }

        let responseFailedNumberData =
          response->getDictFromJsonObject->getArrayFromDict("queryData", [])

        setrefundsDistribution(_ =>
          modifyQuery(responseTotalNumberData, responseFailedNumberData)->JSON.Encode.array
        )

        setScreenState(_ => PageLoaderWrapper.Success)
      } else {
        setScreenState(_ => PageLoaderWrapper.Custom)
      }
    } catch {
    | _ => setScreenState(_ => PageLoaderWrapper.Custom)
    }
  }

  React.useEffect(() => {
    if startTimeVal->isNonEmptyString && endTimeVal->isNonEmptyString {
      getRefundsDistribution()->ignore
    }
    None
  }, (startTimeVal, endTimeVal, currency, isSampleDataEnabled))

  let params = {
    data: refundsDistribution,
    xKey: Refunds_Failure_Rate->getStringFromVariant,
    yKey: Connector->getStringFromVariant,
  }

  let options = chartEntity.getChatOptions(chartEntity.getObjects(~params))

  <div>
    <ModuleHeader title={entity.title} />
    <Card>
      <PageLoaderWrapper
        screenState customLoader={<Shimmer layoutId=entity.title />} customUI={<NoData />}>
        <FailedRefundsDistributionHeader viewType setViewType />
        <div className="mb-5">
          {switch viewType {
          | Graph => <BarGraph options className="mr-3" />
          | Table => <TableModule data={refundsDistribution} className="mx-7" />
          }}
        </div>
      </PageLoaderWrapper>
    </Card>
  </div>
}
