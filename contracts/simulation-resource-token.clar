;; simulation-resource-token contract

(define-fungible-token simulation-resource-token)

(define-data-var token-uri (string-utf8 256) u"https://example.com/simulation-resource-token-metadata")

(define-public (mint (amount uint) (recipient principal))
  (ft-mint? simulation-resource-token amount recipient)
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (ft-transfer? simulation-resource-token amount sender recipient)
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance simulation-resource-token account))
)

(define-read-only (get-total-supply)
  (ok (ft-get-supply simulation-resource-token))
)

(define-public (burn (amount uint) (sender principal))
  (ft-burn? simulation-resource-token amount sender)
)

