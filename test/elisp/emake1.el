;;; emake.el -- Emacs Support for make

;; Author: Michaël Grünewald
;; Date: Ven  4 mar 2005 09:30:43 CET
;; Description: function to run `make' from within emacs (using `compile')
;; Installation: Magic incantation to put in `dot-emacs'
;;  (require 'emake)
;;  (global-set-key '[f2] 'emake-all)
;;  (global-set-key '[f3] 'emake-install)
;;  (global-set-key '[f4] 'emake-clean)
;;  (global-set-key '[f5] 'emake-run)

(provide 'emake)

(defgroup emake nil
  "Emacs support for make, simple layer over `compile'"
  :group 'processes
  :group 'local)

(defcustom emake-command "make"
  "*The make command used by emake"
  :type 'string
  :group 'local)

(defcustom emake-flags ""
  "*The make flags used by emake"
  :type 'string
  :group 'local)

(make-variable-buffer-local 'emake-flags)

(defun emake-compile (command)
  "EMAKE-COMPILE command runs compile with command as compile-command"
  (let ((compile-command command))
    (compile command)
))

(defun emake-mk-command (arguments)
  "EMAKE-MK-COMMAND prepares the command string for pass it to compile"
  (let ((prepare (function
		  (lambda (s) (if (string= s "") "" (concat " " s))
		    )))
	)
    (format "%s%s%s"
	    emake-command
	    (funcall prepare emake-flags)
	    (funcall prepare arguments)
	    )
))


(defun emake (arguments)
  "EMAKE arguments runs compile with emake-command applied to arguments"
  (emake-compile (emake-mk-command arguments)))

(defun emake-all ()
  "EMAKE-ALL runs a make all"
  (interactive)
  (emake "all")
)

(defun emake-install ()
  "EMAKE-ALL runs a make install"
  (interactive)
  (emake "install")
)

(defun emake-clean ()
  "EMAKE-ALL runs a make clean"
  (interactive)
  (emake "clean")
)

(defun emake-run ()
  "EMAKE-ALL runs a make run"
  (interactive)
  (emake "run")
)

;;; End of file `emake.el'
