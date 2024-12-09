;; temporal-paradox-nft contract

(define-non-fungible-token temporal-paradox-nft uint)

(define-data-var next-token-id uint u0)

(define-map token-uris
  { token-id: uint }
  { uri: (string-utf8 256) }
)

(define-public (mint (recipient principal) (uri (string-utf8 256)))
  (let
    (
      (token-id (var-get next-token-id))
    )
    (try! (nft-mint? temporal-paradox-nft token-id recipient))
    (map-set token-uris
      { token-id: token-id }
      { uri: uri }
    )
    (var-set next-token-id (+ token-id u1))
    (ok token-id)
  )
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (nft-transfer? temporal-paradox-nft token-id sender recipient)
)

(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? temporal-paradox-nft token-id))
)

(define-read-only (get-token-uri (token-id uint))
  (map-get? token-uris { token-id: token-id })
)

