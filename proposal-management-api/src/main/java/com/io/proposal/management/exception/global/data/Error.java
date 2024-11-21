package com.io.proposal.management.exception.global.data;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.time.Instant;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Error {
    private Instant timestamp;
    private Integer status;
    private String message;
    private String path;

    public static ResponseEntity<Error> response(String message, HttpStatus status, String uri){
        return ResponseEntity
                .status(status)
                .body(Error.builder()
                        .timestamp(Instant.now())
                        .message(message)
                        .status(status.value())
                        .path(uri)
                        .build());
    }

}