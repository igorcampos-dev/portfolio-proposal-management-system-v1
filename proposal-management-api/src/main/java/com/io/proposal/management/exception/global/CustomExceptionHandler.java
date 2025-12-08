package com.io.proposal.management.exception.global;

import com.io.proposal.management.exception.global.data.Error;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.stream.Collectors;

@Slf4j
@RestControllerAdvice

public class CustomExceptionHandler {

    @ExceptionHandler(NullPointerException.class)
    public ResponseEntity<Error> handleNullPointerException(NullPointerException e, HttpServletRequest s) {
        log.error("method=NullPointerException | message: {}", e.getMessage());
        return Error.response(e.getMessage(), HttpStatus.NOT_FOUND, s.getRequestURI());
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Error> handleIllegalArgumentException(IllegalArgumentException e, HttpServletRequest s) {
        log.error("method=IllegalArgumentException | message: {}", e.getMessage());
        return Error.response(e.getMessage(), HttpStatus.BAD_REQUEST, s.getRequestURI());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Error> methodArgumentInvalidException(MethodArgumentNotValidException e, HttpServletRequest s) {
        log.error("method=MethodArgumentNotValidException | message: {}", e.getMessage());
        var errorsMessage = this.getErrorMessage(e);
        return Error.response(errorsMessage, HttpStatus.BAD_REQUEST, s.getRequestURI());
    }

    private String getErrorMessage(MethodArgumentNotValidException e) {
        return e.getBindingResult()
                .getAllErrors()
                .stream()
                .map(error -> {
                    String field = ((FieldError) error).getField();
                    String errorMessage = error.getDefaultMessage();
                    return field + " " + errorMessage;
                })
                .collect(Collectors.joining(", "));
    }

}
