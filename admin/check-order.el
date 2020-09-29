;; If a child mode is derived from a parent mode, the child must be
;; listed before the parent. Otherwise the parent will shadow the
;; child and the child will never match.

;; Note that information about parent-child relationships is only
;; available for modes that have been loaded into Emacs. For a
;; comprehensive check, all modes recognized by language-id need to be
;; loaded into Emacs.

(cl-reduce (lambda (modes-so-far language)
             (let ((language-modes (cdr language)))
               (cl-reduce (lambda (modes-so-far mode)
                            (message "%S" modes-so-far)
                            (let ((mode (if (listp mode) (car mode) mode)))
                              (cl-assert (symbolp mode))
                              (let ((parent (apply #'provided-mode-derived-p
                                                   mode modes-so-far)))
                                (when (and parent (not (equal parent mode)))
                                  (error "%S is shadowed by %S" mode parent)))
                              (cons mode modes-so-far)))
                          language-modes
                          :initial-value modes-so-far)))
           language-id--definitions
           :initial-value '())
