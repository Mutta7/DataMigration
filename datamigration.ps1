$tenantId = "54483e05-4020-4609-9222-e17cf085ea14"
$clientId = "48391057-5a94-45f9-9d0d-c81961e64edf"
$clientSecret = "uo.QXhGOivy.~TiV0UwIt.51-Os3e_zq.P"

##GraphAPI 接続
$ReqTokenBody = @{
    Grant_Type = "client_credentials"
    Scope = "https://graph.microsoft.com/.default"
    client_Id = $clientId
    Client_Secret = $clientSecret
}

<#
https://login.microsoftonline.com/f1a44fa4-1b4f-4b01-8760-8db6a9753457/adminconsent
?client_id=0cc80016-52b1-4f4c-ad02-8c63ea9d78a6
&state=qwerzxcv
&redirect_uri=https://localhost/datamigration/permissions
#>

$TokenResponse =Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody


#GraphAPIで情報取得
$apiUrl = "https://graph.microsoft.com/v1.0/users"
$Data = Invoke-RestMethod -Headers @{Authorization = "Bearer $($TokenResponse.access_token)"} -Uri $apiUrl -Method Get
$Users = ($Data | select-object Value ).Value
$Users | Format-Table DisplayName -AutoSize

$userObjectId = "f2e31024-93dc-4672-84f3-4cef610806b2"
$apiUrl_getUserDrive = "https://graph.microsoft.com/v1.0/users/$userObjectId/drive"
$drives = Invoke-RestMethod -Headers @{Authorization = "Bearer $($TokenResponse.access_token)"} -Uri $apiUrl_getUserDrive -Method Get
$drives

$apiUrl_upload = ""
Invoke-RestMethod -Headers @{Authorization = "Bearer $($TokenResponse.access_token)"} -Uri $apiUrl_upload -Method Get
<#
    PUT /drives/{drive-id}/items/{parent-id}:/{filename}:/content
    PUT /groups/{group-id}/drive/items/{parent-id}:/{filename}:/content
    PUT /me/drive/items/{parent-id}:/{filename}:/content
    PUT /sites/{site-id}/drive/items/{parent-id}:/{filename}:/content
    PUT /users/{user-id}/drive/items/{parent-id}:/{filename}:/content
#>
