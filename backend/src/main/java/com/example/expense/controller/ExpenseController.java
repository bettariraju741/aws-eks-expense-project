package com.example.expense.controller;

import com.example.expense.entity.Expense;
import com.example.expense.service.ExpenseService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/expenses")
@CrossOrigin(origins = "*")
public class ExpenseController {

    private final ExpenseService service;

    public ExpenseController(
        ExpenseService service
    ) {
        this.service = service;
    }

    @GetMapping
    public List<Expense> getAllExpenses() {

        return service.getAllExpenses();
    }

    @GetMapping("/{id}")
    public Expense getExpense(
        @PathVariable Long id
    ) {

        return service.getExpense(id);
    }

    @PostMapping
    public Expense createExpense(
        @RequestBody Expense expense
    ) {

        return service.createExpense(
            expense
        );
    }

    @PutMapping("/{id}")
    public Expense updateExpense(
        @PathVariable Long id,
        @RequestBody Expense expense
    ) {

        return service.updateExpense(
            id,
            expense
        );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExpense(
        @PathVariable Long id
    ) {

        service.deleteExpense(id);

        return ResponseEntity
            .noContent()
            .build();
    }
}
