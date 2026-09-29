package com.example.expense.service;

import com.example.expense.entity.Expense;
import com.example.expense.repository.ExpenseRepository;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExpenseService {

    private final ExpenseRepository repository;

    public ExpenseService(
        ExpenseRepository repository
    ) {
        this.repository = repository;
    }

    public List<Expense> getAllExpenses() {
        return repository.findAll();
    }

    public Expense getExpense(Long id) {

        return repository.findById(id)
            .orElseThrow(
                () -> new RuntimeException(
                    "Expense not found: " + id
                )
            );
    }

    public Expense createExpense(
        Expense expense
    ) {
        return repository.save(expense);
    }

    public Expense updateExpense(
        Long id,
        Expense updatedExpense
    ) {

        Expense existing =
            getExpense(id);

        existing.setDescription(
            updatedExpense.getDescription()
        );

        existing.setAmount(
            updatedExpense.getAmount()
        );

        existing.setCategory(
            updatedExpense.getCategory()
        );

        return repository.save(existing);
    }

    public void deleteExpense(Long id) {

        repository.deleteById(id);
    }
}
