;; temporal-paradox-scenario contract

(define-data-var next-scenario-id uint u0)

(define-map scenarios
  { scenario-id: uint }
  {
    creator: principal,
    description: (string-utf8 1000),
    parameters: (list 10 { name: (string-ascii 64), value: (string-utf8 256) }),
    status: (string-ascii 20)
  }
)

(define-public (create-scenario (description (string-utf8 1000)) (parameters (list 10 { name: (string-ascii 64), value: (string-utf8 256) })))
  (let
    (
      (scenario-id (var-get next-scenario-id))
    )
    (map-set scenarios
      { scenario-id: scenario-id }
      {
        creator: tx-sender,
        description: description,
        parameters: parameters,
        status: "created"
      }
    )
    (var-set next-scenario-id (+ scenario-id u1))
    (ok scenario-id)
  )
)

(define-public (update-scenario-status (scenario-id uint) (new-status (string-ascii 20)))
  (let
    (
      (scenario (unwrap! (map-get? scenarios { scenario-id: scenario-id }) (err u404)))
    )
    (asserts! (is-eq tx-sender (get creator scenario)) (err u403))
    (ok (map-set scenarios
      { scenario-id: scenario-id }
      (merge scenario { status: new-status })
    ))
  )
)

(define-read-only (get-scenario (scenario-id uint))
  (map-get? scenarios { scenario-id: scenario-id })
)

