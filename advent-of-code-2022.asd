(defsystem "advent-of-code-2022"
    :version "0.1.0"
    :author "Daniel Ma"
    :license "ISC"
    :depends-on ()
    :components ((:module "src"
                          :components
                          ((:file "main"))))
    :description ""
    :in-order-to ((test-op (test-op "advent-of-code-2022/tests"))))

(defsystem "advent-of-code-2022/tests"
    :author ""
    :license ""
    :depends-on ("advent-of-code-2022"
                 "rove")
    :components ((:module "tests"
                          :components
                          ((:file "main"))))
    :description "Test system for advent-of-code-2022"
    :perform (test-op (op c) (symbol-call :rove :run c)))
